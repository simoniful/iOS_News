//
//  NewsResponseModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import Foundation

struct NewsResponseModel: Decodable {
    var items: [News] = []
}
