//
//  NewsSearchManagerProtocol.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation

protocol NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping (Result<NewsData, SearchError>) -> Void
    )
}
