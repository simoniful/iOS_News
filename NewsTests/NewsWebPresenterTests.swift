//
//  NewsWebPresenterTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import XCTest
import CoreData
@testable import News

class NewsWebPresenterTests: XCTestCase {
    var sut: NewsWebPresenter!
    
    var viewController: MockNewsWebViewController!
    var coreDataManager: MockCoreDataManager!
    var news: News!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockNewsWebViewController()
        coreDataManager = MockCoreDataManager()
        news = News(
            title: "\'토종\' <b>코로나</b> 백신 나온다...원료~완제품 이달내 허가",
            originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' <b>코로나</b>19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 <b>코로나</b>19... ",
            pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
            isScraped: false
        )
        
        sut = NewsWebPresenter(
            viewController: viewController,
            coreDataManager: coreDataManager,
            news: news
        )
    }
    
    override func tearDown() {
        sut = nil
        news = nil
        coreDataManager = nil
        viewController = nil
    }
    
    func test_viewDidLoad가_요청될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupWebView)
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
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
}
