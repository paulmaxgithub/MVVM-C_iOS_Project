//
//  AddEventViewController.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 17.10.22.
//

import UIKit

final class AddEventViewController: UIViewController {
    
    public var viewModel: AddEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
