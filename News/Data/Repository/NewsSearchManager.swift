//
//  NetworkManager.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import Foundation
import Alamofire

struct NewsSearchManager: NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        display: Int,
        start: Int,
        completionHandler: @escaping (Result<NewsData, SearchError>) -> Void
    ) {
        let newsAPI = NewsAPI(query: keyword, display: display, start: start)
        
        AF
            .request(
                newsAPI.url,
                method: .get,
                parameters: newsAPI.parameters,
                headers: newsAPI.headers
            )
            .responseDecodable(of: NewsSearchResponseDTO.self) { response in
                switch response.result {
                case .success(let data):
                    let newsData = data.toEntity()
                    completionHandler(.success(newsData))
                case .failure(let error):
                    print(error)
                    if let statusCode = response.response?.statusCode {
                        completionHandler(.failure(SearchError(rawValue: statusCode) ?? .badRequest))
                    } else {
                        completionHandler(.failure(SearchError(rawValue: 500) ?? .systemError))
                    }
                }
            }
            .resume()
    }
}
