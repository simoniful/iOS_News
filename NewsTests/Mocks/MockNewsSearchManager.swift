//
//  MockNewsSearchManager.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/06/27.
//

import Foundation
@testable import News

final class MockNewsSearchManager: NewsSearchManagerProtocol {
    var error: Error?
    var isCalledRequest = false
    
    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping (Result<NewsData, SearchError>) -> Void
    ) {
        isCalledRequest = true
        if error == nil {
            completionHandler(.success(NewsData(item: [], total: 0, start: 1, display: 20)))
        }
    }
}
