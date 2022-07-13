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
    var mockData = News(
        title: "\'토종\' 코로나 백신 나온다...원료~완제품 이달내 허가",
        originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
        link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
        desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' 코로나19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 코로나19... ",
        pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
        isScraped: false
    )
    
    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping (Result<NewsData, SearchError>) -> Void
    ) {
        isCalledRequest = true
        if error == nil {
            completionHandler(
                .success(
                    NewsData(
                        item: [mockData],
                        total: 1,
                        start: 1,
                        display: 20
                    )
                )
            )
        }
    }
}
