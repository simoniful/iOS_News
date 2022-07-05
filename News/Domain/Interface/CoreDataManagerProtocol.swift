//
//  CoreDataManagerProtocol.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/05.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]
    @discardableResult func saveNews(item: News) -> Bool
    @discardableResult func deleteNews(object: NSManagedObject) -> Bool
}
