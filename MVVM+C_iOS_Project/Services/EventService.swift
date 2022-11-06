//
//  EventService.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 6.11.22.
//

import UIKit
import CoreData

protocol EventServiceProtocol {
    func perform(_ action: EventService.EventAction, _ data: EventService.EventInputData)
    func getEvent(_ id: NSManagedObjectID) -> Event?
    func getAllEvents() -> [Event]
}

final class EventService: EventServiceProtocol {
    
    enum EventAction {
        case add
        case update(Event)
    }
    
    struct EventInputData {
        let name: String
        let date: Date
        let image: UIImage
    }
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func perform(_ action: EventAction, _ data: EventInputData) {
        let event: Event
        switch action {
        case .add:
            event = Event(context: coreDataManager.moc)
        case .update(let _event):
            event = _event
        }
        
        event.setValue(data.name, forKey: "name")
        event.setValue(data.date, forKey: "date")
        let resizedImage = data.image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        coreDataManager.save()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        return coreDataManager.get(id)
    }
    
    func getAllEvents() -> [Event] {
        return coreDataManager.getAll()
    }
}
