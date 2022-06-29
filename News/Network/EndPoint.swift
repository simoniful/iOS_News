//
//  EndPoint.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation
import Alamofire

final class NewsAPI {
    let query: String
    let display: Int
    let start: Int
    
    init(query: String, display: Int, start: Int) {
        self.query = query
        self.display = display
        self.start = start
    }
    
    let url = URL(string: "https://openapi.naver.com/v1/search/news.json")!
    
    lazy var parameters = NewsRequestModel(
        query: query,
        display: display,
        start: start,
        sort: "date"
    )
    
    let headers: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.X_Naver_Client_Id ?? "",
        "X-Naver-Client-Secret": APIKey.X_Naver_Client_Secret ?? ""
    ]
}
