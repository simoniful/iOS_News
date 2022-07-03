//
//  NewsScrapPresenterTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import XCTest
@testable import News

class NewsScrapPresenterTests: XCTestCase {
    var sut: NewsScrapPresenter!
    
    var viewController: MockNewsScrapViewController!
    var coreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockNewsScrapViewController()
        coreDataManager = MockCoreDataManager()
        
        sut = NewsScrapPresenter(
            viewController: viewController,
            coreDataManager: coreDataManager
        )
    }
    
    override func tearDown() {
        sut = nil
        coreDataManager = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_요청될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupLayout)
    }
    
    func test_viewWillAppear가_요청될_때() {
        sut.viewWillAppear()
        
        XCTAssertTrue(coreDataManager.isCalledFetchData)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
    
    func test_Table에서_didSelectRowAt가_요청될_때() {
        sut.scrapedNewsList = [
            ScrapedNews()
        ]
        
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(viewController.isCalledPushToNewsWebViewController)
    }
    
    func test_Table에서_commit가_요청될_때() {
        sut.scrapedNewsList = [
            ScrapedNews()
        ]
        
        sut.tableView(UITableView(), commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(coreDataManager.isCalledDeleteNews)
        XCTAssertTrue(viewController.isCalledDeleteTableRow)
    }
}
