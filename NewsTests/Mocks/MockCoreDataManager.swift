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
    
    lazy var persistentContainer: NSPersistentContainer = {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            let container = NSPersistentContainer(name: "NewsData")
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetchData<T>(request: NSFetchRequest<T>) -> [T] where T : NSManagedObject {
        isCalledFetchData = true
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @discardableResult func saveNews(item: News) -> Bool {
        isCalledSaveNews = true
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
        isCalledDeleteNews = true
        self.context.delete(object)
        do {
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
    
}
