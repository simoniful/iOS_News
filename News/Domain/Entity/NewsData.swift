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
