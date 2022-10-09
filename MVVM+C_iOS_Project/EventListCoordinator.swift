//
//  EventListCoordinator.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 13.07.22.
//

import UIKit

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListController = EventListViewController.instantiate()
        navigationController.setViewControllers([eventListController], animated: false)
    }
}
