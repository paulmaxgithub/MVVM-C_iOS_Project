//
//  ImagePickerCoordinator.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 23.10.22.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    public var parentCoordinator: AddEventCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController.present(imagePickerController, animated: true)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            parentCoordinator?.didFinishPicking(image)
        }
        parentCoordinator?.childDidFinish(self)
    }
}
