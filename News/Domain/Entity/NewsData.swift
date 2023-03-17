//
//  NewsData.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation

struct NewsData {
    let item: [News]
    let total: Int
    let start: Int
    let display: Int
}

// TODO: 관리에 있어서 Identifiable 준수 필요
struct News: Equatable {
    let title: String
    let originallink: String
    let link: String
    let desc: String
    let pubDate: String
    var isScraped: Bool
    
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.title == rhs.title
    }
}

extension News {
    init(scrapedNews: ScrapedNews) {
        self.title = scrapedNews.title ?? ""
        self.originallink = scrapedNews.title ?? ""
        self.link = scrapedNews.link ?? ""
        self.desc = scrapedNews.desc ?? ""
        self.pubDate = scrapedNews.pubDate ?? ""
        self.isScraped = scrapedNews.isScraped
    }
}
