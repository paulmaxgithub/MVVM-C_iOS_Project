//
//  EventListViewController.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 13.07.22.
//

import UIKit
import CoreData

class EventListViewController: UIViewController {
    
    public var viewModel: EventListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - View Setup
    private func setupViews() {
        ///Right Bar Button Setup
        let image = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(
            image: image, style: .plain, target: self, action: #selector(tappedAddEventButton))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Actions
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }
}
