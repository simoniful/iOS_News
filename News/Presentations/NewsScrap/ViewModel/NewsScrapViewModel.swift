//
//  NewsScrapViewModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/11.
//

import Foundation
import RxSwift
import RxCocoa

final class NewsScrapViewModel: NSObject, ViewModel {
    var disposeBag = DisposeBag()
    
    weak var coordinator: NewsScrapCoordinator?
    private let dataBaseUseCase: DataBaseUseCase
    
    init(
        coordinator: NewsScrapCoordinator,
        dataBaseUseCase: DataBaseUseCase = DataBaseUseCase(
            repository: CoreDataManager.shared
        )
    ) {
        self.coordinator = coordinator
        self.dataBaseUseCase = dataBaseUseCase
    }
    
    struct Input {
        let didSelectRowAt: Signal<ScrapedNews>
        let deleteForRowAt: Signal<IndexPath>
        let viewWillAppear: Signal<Void>
    }
    
    struct Output {
        let scrapedNewsList: Driver<[ScrapedNews]>
    }
    
    private let scrapedNewsList = BehaviorRelay<[ScrapedNews]>(value: [])
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .emit(onNext: { [weak self] _ in
                self?.requestScrapedNewsList()
            })
            .disposed(by: disposeBag)
        
        input.didSelectRowAt
            .emit(onNext: { [weak self] scrapedNews in
                guard let self = self else { return }
                let news = News(scrapedNews: scrapedNews)
                self.coordinator?.pushNewsWebViewController(
                    news: news, scrapedNews: scrapedNews
                )
            })
            .disposed(by: disposeBag)
        
        input.deleteForRowAt
            .emit(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let deleteOne = self.scrapedNewsList.value[indexPath.row]
                self.dataBaseUseCase.deleteNews(object: deleteOne)
                let newValue = self.scrapedNewsList.value.filter { $0 != deleteOne }
                self.scrapedNewsList.accept(newValue)
            })
            .disposed(by: disposeBag)
        
        return Output(scrapedNewsList: scrapedNewsList.asDriver())
    }
}

private extension NewsScrapViewModel {
    func requestScrapedNewsList() {
        let fetchedData = dataBaseUseCase.fetchData(request: ScrapedNews.fetchRequest())
        scrapedNewsList.accept(fetchedData)
    }
}
