//
//  MockCoreDataManager.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import Foundation
import CoreData
@testable import News

final class MockCoreDataManager: CoreDataManagerProtocol {
    var isCalledFetchData = false
    var isCalledSaveNews = false
    var isCalledDeleteNews = false
    
    func fetchData<T>(request: NSFetchRequest<T>) -> [T] where T : NSManagedObject {
        isCalledFetchData = true
        return []
    }
    
    func saveNews(item: News) -> Bool {
        isCalledSaveNews = true
        return true
    }
    
    func deleteNews(object: NSManagedObject) -> Bool {
        isCalledDeleteNews = true
        return true
    }
}
