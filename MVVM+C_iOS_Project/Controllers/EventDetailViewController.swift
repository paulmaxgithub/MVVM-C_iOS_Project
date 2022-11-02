//
//  EventDetailViewController.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 29.10.22.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackview! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    
    public var viewModel: EventDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            guard let `self` = self,
            let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            self.backgroundImageView.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
