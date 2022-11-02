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
    
    private let coreDataManager: CoreDataManager
    
    var onUpdate = {}
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    public func viewDidLoad() {
        reload()
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
    
    public func reload() {
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(eventCellViewModel)
        }
        onUpdate()
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
