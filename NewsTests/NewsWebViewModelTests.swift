//
//  NewsWebPresenterTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import XCTest
import CoreData
import WebKit
import RxSwift
import RxTest

@testable import News

class NewsWebViewModelTests: XCTestCase {
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: NewsWebViewModel.Input!
    private var output: NewsWebViewModel.Output!
    
    private var viewModel: NewsWebViewModel!
    private var coreDataManager =  MockCoreDataManager()
    private var dataBaseUseCase: DataBaseUseCase!
    private var news: News!
    
    private var navigation = WKNavigation()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        dataBaseUseCase = DataBaseUseCase(repository: coreDataManager)
        news = News(
            title: "\'토종\' 코로나 백신 나온다...원료~완제품 이달내 허가",
            originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' 코로나19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 코로나19... ",
            pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
            isScraped: false
        )
        
        viewModel = NewsWebViewModel(
            coordinator: nil,
            dataBaseUseCase: dataBaseUseCase,
            news: news,
            scrapedNews: nil
        )
    }
    
    override func tearDown() {
        viewModel = nil
        news = nil
        dataBaseUseCase = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_rightBarBookmarkButtonTapped가_요청될_때_news의_isScraped가_false라면() {
        let rightBarCopyButtonTappedEvent = scheduler.createHotObservable([
            .next(2, ())
        ])

        let rightBarBookmarkButtonTappedEvent = scheduler.createHotObservable([
            .next(1, ())
        ])
        
        let webViewLoadedEvent = scheduler.createHotObservable([
            .next(0, navigation)
        ])
        
        input = NewsWebViewModel.Input(
            rightBarCopyButtonTapped: rightBarCopyButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            rightBarBookmarkButtonTapped: rightBarBookmarkButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            webViewLoaded: webViewLoadedEvent.asObservable()
        )
        output = viewModel.transform(input: input)
        
        scheduler.start()
        
        XCTAssertTrue(coreDataManager.isCalledSaveNews)
        XCTAssertTrue(coreDataManager.isCalledFetchData)
    }
    
    func test_rightBarBookmarkButtonTapped가_요청될_때_news의_isScraped가_true라면() {
        viewModel.news.isScraped = true
        viewModel.scrapedNews = ScrapedNews()
        
        let rightBarCopyButtonTappedEvent = scheduler.createHotObservable([
            .next(2, ())
        ])

        let rightBarBookmarkButtonTappedEvent = scheduler.createHotObservable([
            .next(1, ())
        ])
        
        let webViewLoadedEvent = scheduler.createHotObservable([
            .next(0, navigation)
        ])
        
        input = NewsWebViewModel.Input(
            rightBarCopyButtonTapped: rightBarCopyButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            rightBarBookmarkButtonTapped: rightBarBookmarkButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            webViewLoaded: webViewLoadedEvent.asObservable()
        )
        output = viewModel.transform(input: input)
        
        scheduler.start()
        
        XCTAssertTrue(coreDataManager.isCalledDeleteNews)
    }
}
