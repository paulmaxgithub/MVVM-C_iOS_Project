//
//  EventListViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 11.10.22.
//

import Foundation

final class EventListViewModel {
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    
    public let title = "Event"
    
    public var coordinator: EventListCoordinator?

    private let eventService: EventServiceProtocol
    
    var onUpdate = {}
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    public func viewDidLoad() {
        reload()
    }
    
    public func reload() {
            EventCellViewModel.imageCache.removeAllObjects()
            let events = eventService.getAllEvents()
            cells = events.map {
                var eventCellViewModel = EventCellViewModel($0)
                if let coordinator = coordinator {
                    eventCellViewModel.onSelect = coordinator.onSelect
                }
                return .event(eventCellViewModel)
            }
            onUpdate()
    }
    
    public func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    public func numberOfRows() -> Int {
        return cells.count
    }
    
    public func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
