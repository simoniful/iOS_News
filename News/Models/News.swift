//
//  News.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import Foundation

struct News: Decodable {
    let title: String
    let originallink: String
    let link: String
    let description: String
    let pubDate: String
    var isScrabed: Bool
    
    private enum CodingKeys: String, CodingKey {
        case title, originallink, link, description, pubDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        originallink = try container.decodeIfPresent(String.self, forKey: .originallink) ?? ""
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? ""
        isScrabed = false
    }
    
    init(
        title: String,
        originallink: String,
        link: String,
        description: String,
        pubDate: String,
        isScrabed: Bool = false
    ) {
        self.title = title
        self.originallink = originallink
        self.link = link
        self.description = description
        self.pubDate = pubDate
        self.isScrabed = isScrabed
    }
}
