//
//  NewsListViewModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/09.
//

import Foundation
import RxSwift
import RxCocoa

final class NewsListViewModel: NSObject, ViewModel {
    var disposeBag = DisposeBag()
    
    weak var coordinator: NewsListCoordinator?
    private let searchUseCase: SearchUseCase
    
    var tags: [String] = ["IT", "개발", "iOS", "WWDC", "Apple"]
    
    private var currentKeyword: String = ""
    private var currentPage: Int = 0
    var totalCount = 0
    private let display: Int = 20
    
    init(
        coordinator: NewsListCoordinator,
        searchUseCase: SearchUseCase
    ) {
        self.coordinator = coordinator
        self.searchUseCase = searchUseCase
    }
    
    struct Input {
        let didSelectRowAt: Signal<News>
        let rightBarButtonTapped: Signal<Void>
        let refreshSignal: Signal<Void>
        let prefetchRowsAt: Signal<[IndexPath]>
    }
    
    struct Output {
        let newsList: Driver<[News]>
        let showToastAction: Signal<String>
        let reloadTable: Signal<Void>
        let endRefreshing: Signal<Void>
        let scrollToTop: Signal<Void>
    }
    
    private let newsList = BehaviorRelay<[News]>(value: [])
    private let showToastAction = PublishRelay<String>()
    private let reloadTable = PublishRelay<Void>()
    private let endRefreshing = PublishRelay<Void>()
    private let scrollToTop = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        input.didSelectRowAt
            .emit(onNext: { [weak self] news in
                guard let self = self else { return }
                self.coordinator?.pushNewsWebViewController(
                    news: news,
                    scrapedNews: nil
                )
            })
            .disposed(by: disposeBag)
        
        input.rightBarButtonTapped
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.coordinator?.presentNewsTagmakerViewController(
                    tags: self.tags,
                    newsTagmakerDelegate: self
                )
            })
            .disposed(by: disposeBag)
        
        input.refreshSignal
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.requestNewsList(isNeededToReset: true)
            })
            .disposed(by: disposeBag)
        
        input.prefetchRowsAt
            .emit(onNext: { [weak self] indexPaths in
                guard let self = self else { return }
                for indexPath in indexPaths {
                    let limitIndex = self.newsList.value.count - 1
                    if limitIndex == indexPath.row && self.newsList.value.count < self.totalCount {
                        self.requestNewsList(isNeededToReset: false)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            newsList: newsList.asDriver(),
            showToastAction: showToastAction.asSignal(),
            reloadTable: reloadTable.asSignal(),
            endRefreshing: endRefreshing.asSignal(),
            scrollToTop: scrollToTop.asSignal()
        )
    }
}

private extension NewsListViewModel {
    func requestNewsList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            totalCount = 0
            newsList.accept([])
        }
        
        searchUseCase.request(
            from: currentKeyword,
            display: display,
            start: (currentPage * display) + 1,
            completionHandler: {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    let newValue = data.item
                    let oldValue = self.newsList.value
                    self.newsList.accept(oldValue + newValue)
                    self.currentPage += 1
                    self.totalCount = data.total
                    self.endRefreshing.accept(())
                    if isNeededToReset {
                        self.scrollToTop.accept(())
                    }
                case .failure(let error):
                    self.showToastAction.accept(error.errorDescription)
                }
            })
    }
}


extension NewsListViewModel: NewsTagmakerDelegate {
    func makeTags(_ tags: [String]) {
        self.tags = tags
        self.reloadTable.accept(())
    }
}

extension NewsListViewModel: NewsListViewHeaderDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        currentKeyword = tags[selectedIndex]
        requestNewsList(isNeededToReset: true)
    }
}
