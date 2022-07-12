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

struct News {
    let title: String
    let originallink: String
    let link: String
    let desc: String
    let pubDate: String
    var isScraped: Bool
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
