//
//  NewsSearchResponseDTO.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation

struct NewsSearchResponseDTO: Codable {
    let items: [DatumDTO]
    let total: Int
    let start: Int
    let display: Int
}

struct DatumDTO: Codable {
    let title: String
    let originallink: String
    let link: String
    let desc: String
    let pubDate: String

    enum CodingKeys: String, CodingKey {
        case title, originallink, link
        case desc = "description"
        case pubDate
    }
}

extension NewsSearchResponseDTO {
    func toEntity() -> NewsData {
        return .init(
            item: items.map { $0.toEntity() },
            total: total,
            start: start,
            display: display
        )
    }
}

extension DatumDTO {
    func toEntity() -> News {
        return .init(
            title: title.htmlToString,
            originallink: originallink,
            link: link,
            desc: desc.htmlToString,
            pubDate: pubDate,
            isScraped: false
        )
    }
}


