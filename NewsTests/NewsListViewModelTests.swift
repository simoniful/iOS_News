//
//  NewsListPresenterTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/06/26.
//

import XCTest
@testable import News

class NewsListPresenterTests: XCTestCase {
//    var sut: NewsListPresenter!
//    var viewController: MockNewsListViewController!
//    var searchUseCase: SearchUseCase!
//    var newsSearchManager = MockNewsSearchManager()
//    
//    override func setUp() {
//        super.setUp()
//        
//        viewController = MockNewsListViewController()
//        searchUseCase = SearchUseCase(repository: newsSearchManager)
//        
//        sut = NewsListPresenter(
//            viewController: viewController,
//            searchUseCase: searchUseCase
//        )
//    }
//    
//    override func tearDown() {
//        sut = nil
//        viewController = nil
//        searchUseCase = nil
//        
//        super.tearDown()
//    }
//    
//    func test_viewDidLoad가_요청될_때() {
//        sut.viewDidLoad()
//        
//        XCTAssertTrue(viewController.isCalledSetupLayout)
//    }
//    
//    func test_viewWillAppear가_요청될_때() {
//        sut.viewWillAppear()
//        
//        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
//    }
//    
//    func test_viewWillDisappear가_요청될_때() {
//        sut.viewWillDisappear()
//        
//        XCTAssertTrue(viewController.isCalledRemoveRightButton)
//        XCTAssertTrue(viewController.isCalledChangeNavigationTitleSize)
//    }
//    
//    func test_didCalledRefresh가_요청될_때_request에_실패하면() {
//        newsSearchManager.error = NSError() as Error
//        sut.didCalledRefresh()
//        
//        XCTAssertTrue(newsSearchManager.isCalledRequest)
//        XCTAssertFalse(viewController.isCalledReloadTableView)
//        XCTAssertFalse(viewController.isCalledEndRefreshing)
//    }
//    
//    func test_didCalledRefresh가_요청될_때_request에_성공하면() {
//        newsSearchManager.error = nil
//        sut.didCalledRefresh()
//        
//        XCTAssertTrue(newsSearchManager.isCalledRequest)
//        XCTAssertTrue(viewController.isCalledReloadTableView)
//        XCTAssertTrue(viewController.isCalledEndRefreshing)
//        XCTAssertTrue(viewController.isCalledScrollToTop)
//    }
//    
//    func test_didTapRightBarButton가_요청될_때() {
//        sut.didTapRightBarButton()
//        
//        XCTAssertTrue(viewController.isCalledPushToNewsTagmakerViewController)
//    }
//    
//    func test_Table에서_didSelectRowAt가_요청될_때() {
//        sut.newsList = [
//            News(
//                title: "\'토종\' <b>코로나</b> 백신 나온다...원료~완제품 이달내 허가",
//                originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
//                link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
//                desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' <b>코로나</b>19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 <b>코로나</b>19... ",
//                pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
//                isScraped: false
//            )
//        ]
//        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
//        
//        XCTAssertTrue(viewController.isCalledPushToNewsWebViewController)
//    }
//    
//    func test_Table에서_prefetchRowsAt가_요청될_때() {
//        sut.totalCount = 40
//        sut.newsList = Array(
//            repeating: News(
//                title: "\'토종\' <b>코로나</b> 백신 나온다...원료~완제품 이달내 허가",
//                originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
//                link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
//                desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' <b>코로나</b>19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 <b>코로나</b>19... ",
//                pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
//                isScraped: false
//            ),
//            count: 20
//        )
//        sut.tableView(UITableView(), prefetchRowsAt: [IndexPath(row: 19, section: 0)])
//        
//        XCTAssertTrue(newsSearchManager.isCalledRequest)
//        XCTAssertTrue(viewController.isCalledReloadTableView)
//        XCTAssertTrue(viewController.isCalledEndRefreshing)
//        XCTAssertFalse(viewController.isCalledScrollToTop)
//    }
//    
//    func test_Header에서_didSelectTag가_요청될_때() {
//        sut.didSelectTag(0)
//        
//        XCTAssertTrue(newsSearchManager.isCalledRequest)
//        XCTAssertTrue(viewController.isCalledReloadTableView)
//        XCTAssertTrue(viewController.isCalledEndRefreshing)
//        XCTAssertTrue(viewController.isCalledScrollToTop)
//    }
//    
//    func test_delegate로_makeTags가_요청될_때() {
//        sut.makeTags([])
//        
//        XCTAssertTrue(viewController.isCalledReloadTableView)
//    }
}



