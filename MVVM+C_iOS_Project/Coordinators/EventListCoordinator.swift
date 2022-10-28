//
//  EventListCoordinator.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 13.07.22.
//

import UIKit

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    public var onSaveEvent = {}
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListController: EventListViewController = .instantiate()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        eventListController.viewModel = eventListViewModel
        onSaveEvent = eventListViewModel.reload
        navigationController.setViewControllers([eventListController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === childCoordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
