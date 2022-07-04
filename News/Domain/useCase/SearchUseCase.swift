//
//  SearchUseCase.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/04.
//

import Foundation

final class SearchUseCase {

    let repository: NewsSearchManagerProtocol

    init(repository: NewsSearchManagerProtocol) {
        self.repository = repository
    }

    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping (Result<NewsData, SearchError>) -> Void
    ) {
        repository.request(
            from: keyword,
            display: display,
            start: start,
            completionHandler: completionHandler
        )
    }
}
