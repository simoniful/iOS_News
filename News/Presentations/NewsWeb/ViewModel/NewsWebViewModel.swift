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
    var news: News
    var scrapedNews: ScrapedNews?
    
    init(
        coordinator: Coordinator?,
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
    
    private let showToastAction = PublishRelay<String>()
    private let indicatorAction = BehaviorRelay<Bool>(value: true)
    private lazy var scrapedState = BehaviorRelay<Bool>(value: news.isScraped)
    
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
                    self.setNewsScraped(news: self.news)
                } else {
                    guard let scrapedNews = self.scrapedNews else { return }
                    self.setNewsUnscraped(scrapedNews: scrapedNews)
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

private extension NewsWebViewModel {
    func setNewsScraped(news: News) {
        dataBaseUseCase.saveNews(item: news)
        let request: NSFetchRequest<ScrapedNews> = ScrapedNews.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS %@", news.title)
        scrapedNews = dataBaseUseCase.fetchData(request: request).first
    }
    
    func setNewsUnscraped(scrapedNews: ScrapedNews) {
        dataBaseUseCase.deleteNews(object: scrapedNews)
    }
}


