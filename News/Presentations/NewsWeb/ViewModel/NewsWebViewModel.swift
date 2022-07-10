//
//  NewsWebViewModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import Foundation
import RxSwift
import RxCocoa
import WebKit
import CoreData

final class NewsWebViewModel: NSObject, ViewModel {
    var disposeBag = DisposeBag()
    
    weak var coordinator: Coordinator?
    private let dataBaseUseCase: DataBaseUseCase
    var news: News {
        didSet {
            scrapedState.accept(news.isScraped)
        }
    }
    var scrapedNews: ScrapedNews?
    
    init(
        coordinator: Coordinator,
        dataBaseUseCase: DataBaseUseCase = DataBaseUseCase(
            repository: CoreDataManager.shared
        ),
        news: News,
        scrapedNews: ScrapedNews?
    ) {
        self.coordinator = coordinator
        self.dataBaseUseCase = dataBaseUseCase
        self.news = news
        self.scrapedNews = scrapedNews
    }
    
    struct Input {
        let rightBarCopyButtonTapped: Signal<Void>
        let rightBarBookmarkButtonTapped: Signal<Void>
        let webViewLoaded: Observable<WKNavigation>
    }
    
    struct Output {
        let showToastAction: Signal<String>
        let indicatorAction: Driver<Bool>
        let scrapedState: Driver<Bool>
    }
    
    let showToastAction = PublishRelay<String>()
    let indicatorAction = BehaviorRelay<Bool>(value: true)
    let scrapedState = BehaviorRelay<Bool>(value: false)
    
    func transform(input: Input) -> Output {
        input.rightBarCopyButtonTapped
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIPasteboard.general.string = self.news.originallink
                self.showToastAction.accept(ToastCase.copied.description)
                
            })
            .disposed(by: disposeBag)
        
        input.rightBarBookmarkButtonTapped
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.news.isScraped.toggle()
                if self.news.isScraped {
                    self.dataBaseUseCase.saveNews(item: self.news)
                    let request: NSFetchRequest<ScrapedNews> = ScrapedNews.fetchRequest()
                    request.predicate = NSPredicate(format: "title CONTAINS %@", self.news.title)
                    self.scrapedNews = self.dataBaseUseCase.fetchData(request: request).first
                } else {
                    if let scrapedNews = self.scrapedNews {
                        self.dataBaseUseCase.deleteNews(object: scrapedNews)
                    }
                }
                self.scrapedState.accept(self.news.isScraped)
            })
            .disposed(by: disposeBag)
        
        input.webViewLoaded
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.indicatorAction.accept(false)
                }
            )
            .disposed(by: disposeBag)
        
        return Output(
            showToastAction: showToastAction.asSignal(),
            indicatorAction: indicatorAction.asDriver(),
            scrapedState: scrapedState.asDriver()
        )
    }
}


