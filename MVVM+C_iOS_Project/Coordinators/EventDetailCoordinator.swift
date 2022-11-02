//
//  EventDetailCoordinator.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 29.10.22.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    public var parentCoordinator: EventListCoordinator?
    
    private let navigationController: UINavigationController
    
    private let eventID: NSManagedObjectID
    
    init(navigationController: UINavigationController, eventID: NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    func start() {
        let eventDetailViewController: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        eventDetailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
