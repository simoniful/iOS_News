//
//  DataBaseUseCase.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/05.
//

import Foundation
import CoreData

final class DataBaseUseCase {
    let repository: CoreDataManagerProtocol

    init(repository: CoreDataManagerProtocol) {
        self.repository = repository
    }

    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        repository.fetchData(request: request)
    }
    
    @discardableResult func saveNews(item: News) -> Bool {
        repository.saveNews(item: item)
    }
    
    @discardableResult func deleteNews(object: NSManagedObject) -> Bool {
        repository.deleteNews(object: object)
    }
}
