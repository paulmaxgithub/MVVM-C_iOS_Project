//
//  EventListViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 11.10.22.
//

import Foundation

final class EventListViewModel {
    
    public let title = "Event"
    
    public var coordinator: EventListCoordinator?
    
    public func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}
