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
    case tagContained
    case stringCountOver
    case tagsSettingCompleted
    case blankTextInput
}

extension ToastCase {
    var description: String {
        switch self {
        case .copied:
            return "클립보드에 복사되었습니다"
        case .webLoadFailed:
            return "사이트를 불러오는데 실패했습니다"
        case .tagContained:
            return "이미 포함된 태그입니다"
        case .stringCountOver:
            return "15자 미만으로 작성해주세요"
        case .tagsSettingCompleted:
            return "검색 태그가 변경되었어요"
        case .blankTextInput:
            return "입력 값을 작성해주세요"
        }
    }
}
