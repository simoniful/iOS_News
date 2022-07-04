//
//  CoreDataManager.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]
    @discardableResult func saveNews(item: News) -> Bool
    @discardableResult func deleteNews(object: NSManagedObject) -> Bool
}

final class CoreDataManager: CoreDataManagerProtocol {
    static let shared: CoreDataManager = CoreDataManager()

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return self.container.viewContext
    }

    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    @discardableResult func saveNews(item: News) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "ScrapedNews", in: self.context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)

            managedObject.setValue(true, forKey: "isScraped")
            managedObject.setValue(item.title, forKey: "title")
            managedObject.setValue(item.link, forKey: "link")
            managedObject.setValue(item.originallink, forKey: "originallink")
            managedObject.setValue(item.desc, forKey: "desc")
            managedObject.setValue(item.pubDate, forKey: "pubDate")

            do {
                try self.context.save()
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }

    @discardableResult func deleteNews(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
}
