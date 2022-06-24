//
//  NetworkManager.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import Foundation
import Alamofire

protocol NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping ([News]) -> Void
    )
}

struct NewsSearchManager: NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping ([News]) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return }
        
        let parameters = NewsRequestModel(
            query: keyword,
            display: display,
            start: start,
            sort: "date"
        )
        
        let X_Naver_Client_Id = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Id") as? String
        let X_Naver_Client_Secret = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Secret") as? String
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": X_Naver_Client_Id ?? "",
            "X-Naver-Client-Secret": X_Naver_Client_Secret ?? ""
        ]
        
        AF
            .request(
                url,
                method: .get,
                parameters: parameters,
                headers: headers
            )
            .responseDecodable(of: NewsResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
