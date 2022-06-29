//
//  APIKey.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation

final class APIKey {
    static let X_Naver_Client_Id = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Id") as? String
    static let X_Naver_Client_Secret = Bundle.main.object(forInfoDictionaryKey: "X_Naver_Client_Secret") as? String
    
    // let X_Naver_Client_Id = ProcessInfo.processInfo.environment["X_Naver_Client_Id"]
    // let X_Naver_Client_Secret = ProcessInfo.processInfo.environment["X_Naver_Client_Secret"]
}
