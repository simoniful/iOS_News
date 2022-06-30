//
//  Date +.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/30.
//

import Foundation

enum DatePattern: String {
    case year = "yyyy"
    case date = "M.d(E)"
    case time = "a HH:mm"
    case custom = "yyyy년 M월 d일(E요일) a HH시 mm분"
}

extension Date {
    func toString(pattern: DatePattern) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern.rawValue
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        return dateFormatter.string(from: self)
    }
}
