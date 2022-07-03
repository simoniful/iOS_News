//
//  MockNewsWebViewController.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import Foundation
@testable import News

final class MockNewsWebViewController: NewsWebProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupWebView = false
    var isCalledSetRightBarButton = false
    var isCalledShowToast = false
    var isCalledStopIndicator = false
    
    func setupNavigationBar(with news: News) {
        isCalledSetupNavigationBar = true
    }
    
    func setupWebView(with news: News) {
        isCalledSetupWebView = true
    }
    
    func setRightBarButton(with isScraped: Bool) {
        isCalledSetRightBarButton = true
    }
    
    func showToast(with message: String) {
        isCalledShowToast = true
    }
    
    func stopIndicator() {
        isCalledStopIndicator = true
    }
}
