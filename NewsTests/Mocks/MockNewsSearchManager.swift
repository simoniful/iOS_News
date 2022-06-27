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
        completionHandler: @escaping ([News]) -> Void
    ) {
        print(isCalledRequest)
        isCalledRequest = true
        print(isCalledRequest)
        if error == nil {
            completionHandler([])
        }
    }
}
