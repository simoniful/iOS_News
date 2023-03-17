//
//  SearchError.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation

enum SearchError: Int, Error {
    case badRequest = 400
    case invalidSearchApi = 404
    case systemError = 500
}

extension SearchError {
    var errorDescription: String {
        switch self {
        case .badRequest: return "검색 API 요청에 오류가 있습니다.\n요청 URL, 변수가 정확한지 확인 바랍니다"
        case .invalidSearchApi: return "검색 API 대상에 오타가 없는지 확인해 보세요."
        case .systemError: return "서버 내부 에러가 발생하였습니다.\n포럼에 올려주시면 신속히 조치하겠습니다."
        }
    }
}
