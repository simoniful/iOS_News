//
//  ToastCase.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/09.
//

import Foundation


enum ToastCase {
    case copied
    case webLoadFailed
}

extension ToastCase {
    var description: String {
        switch self {
        case .copied:
            return "클립보드에 복사되었습니다"
        case .webLoadFailed:
            return "사이트를 불러오는데 실패했습니다"
        }
    }
}
