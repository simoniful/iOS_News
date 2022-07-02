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
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func pushToNewsWebViewController(with scrapedNews: ScrapedNews) {
        isCalledPushToNewsWebViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
}
