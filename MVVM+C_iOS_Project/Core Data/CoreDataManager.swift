//
//  CoreDataManager.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 10.10.22.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "Persistent Container Unknown Error")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        } catch (let error) {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try moc.fetch(fetchRequest)
        } catch (let error) {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
    func save() {
        do {
            try moc.save()
        } catch (let error) {
            debugPrint(error.localizedDescription)
        }
    }
}
