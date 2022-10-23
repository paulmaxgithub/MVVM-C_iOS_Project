//
//  AddEventCoordinator.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 17.10.22.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    private var modalNavigationController = UINavigationController()
    
    public var parentCoordinator: EventListCoordinator?
    
    private var completion: (UIImage) -> Void = {_ in}
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventViewController: AddEventViewController = .instantiate()
        modalNavigationController.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel =
        AddEventViewModel(eventsCellBuilder: EventsCellBuilder(), coreDataManager: CoreDataManager())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        navigationController.present(modalNavigationController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        navigationController.dismiss(animated: true, completion: nil)
        didFinish()
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion(image)
        modalNavigationController.dismiss(animated: true, completion: nil)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === childCoordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
