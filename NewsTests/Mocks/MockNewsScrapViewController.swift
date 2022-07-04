//
//  MockNewsScrapViewController.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import Foundation
@testable import News

final class MockNewsScrapViewController: NewsScrapProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupLayout = false
    var isCalledPushToNewsWebViewController = false
    var isCalledReloadTableView = false
    var isCalledDeleteTableRow = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func pushToNewsWebViewController(with scrapedNews: ScrapedNews, news: News) {
        isCalledPushToNewsWebViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
    func deleteTableRow(indexPath: IndexPath) {
        isCalledDeleteTableRow = true
    }
}
