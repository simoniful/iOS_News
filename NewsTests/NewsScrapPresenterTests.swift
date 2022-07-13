//
//  NewsScrapPresenterTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import XCTest
@testable import News

class NewsScrapPresenterTests: XCTestCase {
//    var sut: NewsScrapPresenter!
//    var viewController: MockNewsScrapViewController!
//    var dataBaseUseCase: DataBaseUseCase!
//    var coreDataManager = MockCoreDataManager()
//    
//    override func setUp() {
//        super.setUp()
//        
//        viewController = MockNewsScrapViewController()
//        dataBaseUseCase = DataBaseUseCase(repository: coreDataManager)
//        
//        sut = NewsScrapPresenter(
//            viewController: viewController,
//            dataBaseUseCase: dataBaseUseCase
//        )
//        
//        let mockNews = News(
//            title: "\'토종\' 코로나 백신 나온다...원료~완제품 이달내 허가",
//            originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
//            link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
//            desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' 코로나19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 코로나19... ",
//            pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
//            isScraped: false
//        )
//        
//        Array(repeating: mockNews, count: 5).forEach {
//            coreDataManager.saveNews(item: $0)
//        }
//    }
//    
//    override func tearDown() {
//        coreDataManager.fetchData(request: ScrapedNews.fetchRequest()).forEach {
//            coreDataManager.deleteNews(object: $0)
//        }
//        
//        sut = nil
//        dataBaseUseCase = nil
//        viewController = nil
//        
//        super.tearDown()
//    }
//    
//    func test_viewDidLoad가_요청될_때() {
//        sut.viewDidLoad()
//        
//        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
//        XCTAssertTrue(viewController.isCalledSetupLayout)
//    }
//    
//    func test_viewWillAppear가_요청될_때() {
//        sut.viewWillAppear()
//        
//        XCTAssertTrue(coreDataManager.isCalledFetchData)
//        XCTAssertTrue(viewController.isCalledReloadTableView)
//    }
//    
//    func test_Table에서_didSelectRowAt가_요청될_때() {
//        sut.scrapedNewsList = coreDataManager.fetchData(request: ScrapedNews.fetchRequest())
//        
//        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
//        
//        XCTAssertTrue(viewController.isCalledPushToNewsWebViewController)
//    }
//    
//    func test_Table에서_commit가_요청될_때() {
//        sut.scrapedNewsList = coreDataManager.fetchData(request: ScrapedNews.fetchRequest())
//        
//        sut.tableView(UITableView(), commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
//        
//        XCTAssertTrue(coreDataManager.isCalledDeleteNews)
//        XCTAssertTrue(viewController.isCalledDeleteTableRow)
//    }
}
