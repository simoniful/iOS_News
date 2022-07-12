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
    let disposeBag = DisposeBag()
    
    var coordinator: Coordinator!
    var sut: NewsWebViewModel!
    var dataBaseUseCase: DataBaseUseCase!
    var viewController: MockNewsWebViewController!
    var news: News!
    var coreDataManager =  MockCoreDataManager()
    
    let navigation = WKNavigation()
    
    override func setUp() {
        super.setUp()
        coordinator = MockNewsListCoordinator(UINavigationController())
        dataBaseUseCase = DataBaseUseCase(repository: coreDataManager)
        news = News(
            title: "\'토종\' 코로나 백신 나온다...원료~완제품 이달내 허가",
            originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' 코로나19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 코로나19... ",
            pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
            isScraped: false
        )
        
        sut = NewsWebViewModel(
            coordinator: coordinator,
            dataBaseUseCase: dataBaseUseCase,
            news: news,
            scrapedNews: nil
        )
    }
    
    override func tearDown() {
        sut = nil
        news = nil
        dataBaseUseCase = nil
        coordinator = nil
        
        super.tearDown()
    }
    
    func test_WebView가_로딩됬을_때() {
        let scheduler = TestScheduler(initialClock: 0)
        
        let webViewLoadedEvent = scheduler.createHotObservable([
            .next(1, navigation)
        ])
        
        let webViewLoaded = PublishSubject<WKNavigation>()
        
        webViewLoadedEvent
            .subscribe(webViewLoaded)
            .disposed(by: disposeBag)
    }
    
    func test_didTapRightBarCopyButton가_요청될_때() {
        sut.didTapRightBarCopyButton()
        
        XCTAssertTrue(viewController.isCalledShowToast)
    }
    
    func test_didTapRightBarBookmarkButton가_요청될_때_news의_isScraped가_false라면() {
        sut.didTapRightBarBookmarkButton()
        
        XCTAssertTrue(coreDataManager.isCalledSaveNews)
        XCTAssertTrue(coreDataManager.isCalledFetchData)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    func test_didTapRightBarBookmarkButton가_요청될_때_news의_isScraped가_true라면() {
        sut.news.isScraped = true
        sut.scrapedNews = ScrapedNews()
        sut.didTapRightBarBookmarkButton()
        
        XCTAssertTrue(coreDataManager.isCalledDeleteNews)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    func test_WebView에서_didFinish가_요청될_때() {
        sut.webView(WKWebView(), didFinish: navigation)
        
        XCTAssertTrue(viewController.isCalledStopIndicator)
    }
}
