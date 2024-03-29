//
//  EventDetailViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 29.10.22.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    
    private let eventID: NSManagedObjectID
    private let eventService: EventServiceProtocol
    private var event: Event?
    private let date = Date()
    
    public var coordinator: EventDetailCoordinator?
    
    public var onUpdate = {}
    
    public var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date,
              let timeRemainingParts = date.timeRamaining(until: eventDate)?.components(separatedBy: ",")
        else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
    }
    
    init(eventID: NSManagedObjectID, eventService: EventServiceProtocol = EventService()) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    public func viewDidLoad() {
        reload()
    }
    
    public func reload() {
        event = eventService.getEvent(eventID)
        onUpdate()
    }
    
    public func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    @objc public func editButtonTapped() {
        guard let event = event else { return }
        coordinator?.onEditEvent(event)
    }
}
