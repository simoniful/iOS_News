//
//  NewsTabPageCase.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import Foundation

enum TabBarPageCase: String, CaseIterable {
    case news, bookmark

    init?(index: Int) {
        switch index {
        case 0: self = .news
        case 1: self = .bookmark
        default: return nil
        }
    }

    var pageOrderNumber: Int {
        switch self {
        case .news: return 0
        case .bookmark: return 1
        
        }
    }

    var pageTitle: String {
        switch self {
        case .news:
            return "News"
        case .bookmark:
            return "Bookmark"
        }
    }

    func tabIconName() -> String {
        switch self {
        case .news:
            return "newspaper"
        case .bookmark:
            return "bookmark"
        }
    }
}
