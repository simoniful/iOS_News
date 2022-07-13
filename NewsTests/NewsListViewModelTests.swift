//
//  NewsListViewModelTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/13.
//

import XCTest
import RxSwift
import RxTest

@testable import News

final class NewsListViewModelTests: XCTestCase {
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: NewsListViewModel.Input!
    private var output: NewsListViewModel.Output!

    private var viewModel: NewsListViewModel!
    private var newsSearchManager = MockNewsSearchManager()
    private var searchUseCase: SearchUseCase!
    
    private var mockData = News(
        title: "\'토종\' 코로나 백신 나온다...원료~완제품 이달내 허가",
        originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
        link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
        desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' 코로나19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 코로나19... ",
        pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
        isScraped: false
    )
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        searchUseCase = SearchUseCase(repository: newsSearchManager)
        
        viewModel = NewsListViewModel(
            coordinator: nil,
            searchUseCase: searchUseCase
        )
    }
    
    override func tearDown() {
        viewModel = nil
        searchUseCase = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_refreshSignal이_요청될_때_성공적으로_데이터가_불러와진다면() {
        viewModel.didSelectTag(0)
        
        let didSelectRowAtEvent = scheduler.createHotObservable([
            .next(0, mockData)
        ])
        
        let rightBarButtonTappedEvent = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let refreshSignalEvent = scheduler.createHotObservable([
            .next(5, ())
        ])
        
        let prefetchRowsAtEvent = scheduler.createHotObservable([
            .next(0, [IndexPath(row: 1, section: 0)])
        ])
        
        let newsListObserver = self.scheduler.createObserver([News].self)
        
        input = NewsListViewModel.Input(
            didSelectRowAt: didSelectRowAtEvent.asSignal(onErrorJustReturn: mockData),
            rightBarButtonTapped: rightBarButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            refreshSignal: refreshSignalEvent.asSignal(onErrorJustReturn: ()),
            prefetchRowsAt: prefetchRowsAtEvent.asSignal(onErrorJustReturn: [IndexPath(row: 0, section: 0)])
        )
        
        output = viewModel.transform(input: input)
        
        output
            .newsList
            .drive(newsListObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(newsListObserver.events, [
            .next(0, [mockData]),
            .next(5, []),
            .next(5, [mockData])
        ], "새로고침 시 데이터 갱신 성공 케이스")
    }
    
    func test_refreshSignal이_요청될_때_데이터_불러오기가_실패한다면() {
        viewModel.didSelectTag(0)
        newsSearchManager.error = NSError() as Error
        
        let didSelectRowAtEvent = scheduler.createHotObservable([
            .next(0, mockData)
        ])
        
        let rightBarButtonTappedEvent = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let refreshSignalEvent = scheduler.createHotObservable([
            .next(5, ())
        ])
        
        let prefetchRowsAtEvent = scheduler.createHotObservable([
            .next(0, [IndexPath(row: 1, section: 0)])
        ])
        
        let newsListObserver = self.scheduler.createObserver([News].self)
        
        input = NewsListViewModel.Input(
            didSelectRowAt: didSelectRowAtEvent.asSignal(onErrorJustReturn: mockData),
            rightBarButtonTapped: rightBarButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            refreshSignal: refreshSignalEvent.asSignal(onErrorJustReturn: ()),
            prefetchRowsAt: prefetchRowsAtEvent.asSignal(onErrorJustReturn: [IndexPath(row: 0, section: 0)])
        )
        
        output = viewModel.transform(input: input)
        
        output
            .newsList
            .drive(newsListObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(newsListObserver.events, [
            .next(0, [mockData]),
            .next(5, [])
        ], "새로고침 시 데이터 갱신 실패 케이스")
    }
    
    func test_Table에서_prefetchRowsAt가_요청될_때() {
        viewModel.totalCount = 40
        viewModel.newsList.accept(Array(repeating: mockData, count: 20))
        
        let didSelectRowAtEvent = scheduler.createHotObservable([
            .next(0, mockData)
        ])
        
        let rightBarButtonTappedEvent = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let refreshSignalEvent = scheduler.createHotObservable([
            .next(10, ())
        ])
        
        let prefetchRowsAtEvent = scheduler.createHotObservable([
            .next(5, [IndexPath(row: 19, section: 0)])
        ])
        
        let newsListObserver = self.scheduler.createObserver([News].self)
        
        input = NewsListViewModel.Input(
            didSelectRowAt: didSelectRowAtEvent.asSignal(onErrorJustReturn: mockData),
            rightBarButtonTapped: rightBarButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            refreshSignal: refreshSignalEvent.asSignal(onErrorJustReturn: ()),
            prefetchRowsAt: prefetchRowsAtEvent.asSignal(onErrorJustReturn: [IndexPath(row: 0, section: 0)])
        )
        
        output = viewModel.transform(input: input)
        
        output
            .newsList
            .drive(newsListObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(newsListObserver.events, [
            .next(0, Array(repeating: mockData, count: 20)),
            .next(5, Array(repeating: mockData, count: 21)),
            .next(10, []),
            .next(10, [mockData])
        ], "prefetch시 데이터 요청 성공 케이스")
    }
}
