//
//  MockNewsListViewController.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/06/27.
//

import Foundation
@testable import News

final class MockNewsListViewController: NewsListProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupLayout = false
    var isCalledEndRefreshing = false
    var isCalledPushToNewsWebViewController = false
    var isCalledReloadTableView = false
    var isCalledRemoveRightButton = false
    var isCalledPushToNewsTagmakerViewController = false
    var isCalledMakeTags = false
    var isCalledChangeNavigationTitleSize = false
    var isCalledScrollToTop = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func endRefreshing() {
        isCalledEndRefreshing = true
    }
    
    func pushToNewsWebViewController(with news: News) {
        isCalledPushToNewsWebViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
    func removeRightButton() {
        isCalledRemoveRightButton = true
    }
    
    func pushToNewsTagmakerViewController(with tags: [String]) {
        isCalledPushToNewsTagmakerViewController = true
    }
    
    func changeNavigationTitleSize() {
        isCalledChangeNavigationTitleSize = true
    }
    
    func scrollToTop() {
        isCalledScrollToTop = true
    }
}

extension MockNewsListViewController: NewsTagmakerDelegate {
    func makeTags(_ tags: [String]) {
        isCalledMakeTags = true
    }
}
