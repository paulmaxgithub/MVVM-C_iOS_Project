//
//  AddEventViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 17.10.22.
//

import Foundation

final class AddEventViewModel {
    
    public var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
}
