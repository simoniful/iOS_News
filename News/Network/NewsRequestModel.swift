//
//  NewsRequestModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import Foundation

struct NewsRequestModel: Codable {
    /// 검색어
    let query: String
    /// 검색 결과 출력 건수, 10 ~ 100
    let display: Int
    /// 시작 Index, 1 ~ 1000
    let start: Int
    /// 정렬 옵션: sim (유사도순), date (날짜순)
    let sort: String
}
