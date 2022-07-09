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
    
    weak var coordinator: Coordinator?
    private let searchUseCase: SearchUseCase
    
    private var tags: [String] = ["IT", "개발", "iOS", "WWDC", "Apple"]
    var newsList: [News] = []
    
    private var currentKeyword: String = ""
    private var currentPage: Int = 0
    var totalCount = 0
    private let display: Int = 20
    
    init(
        coordinator: Coordinator,
        searchUseCase: SearchUseCase
    ) {
        self.coordinator = coordinator
        self.searchUseCase = searchUseCase
    }
    
    struct Input {
        let newsListItemSelected: PublishRelay<Int>
        let rightBarButtonTapped: Signal<Void>
    }
    
    struct Output {
        
    }
    
    private let newsListData = PublishSubject<[News]>()
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

private extension NewsListViewModel {
    func requestNewsList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            totalCount = 0
            newsList = []
        }
        
        searchUseCase.request(
            from: currentKeyword,
            display: display,
            start: (currentPage * display) + 1,
            completionHandler: {[weak self] result in
                switch result {
                case .success(let data):
                    let newValue = data.item
                    self?.newsList += newValue
                    self?.currentPage += 1
                    self?.totalCount = data.total
                    self?.viewController?.reloadTableView()
                    self?.viewController?.endRefreshing()
                    if isNeededToReset {
                        self?.viewController?.scrollToTop()
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}
