//
//  EventListViewController.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 13.07.22.
//

import UIKit

class EventListViewController: UIViewController {
    
    static func instantiate() -> EventListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(
            withIdentifier: "EventListViewController") as! EventListViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc private func tappedRightBarButton() {
        print("TAPPED RIGHT BUTTON")
    }
    
    private func setupViews() {
        ///Right Br Button
        let image = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(
            image: image, style: .plain, target: self, action: #selector(tappedRightBarButton))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
