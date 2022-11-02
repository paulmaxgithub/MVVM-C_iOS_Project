//
//  EventCell.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 25.10.22.
//

import UIKit

final class EventCell: UITableViewCell {
    
    private let timeRemainingStackview = TimeRemainingStackview()
    private let dateLabel           = UILabel()
    private let eventLabel          = UILabel()
    private var backgroundImageView = UIImageView()
    private let verticalStackview   = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = UIImage()
    }
    
    private func setupViews() {
        timeRemainingStackview.setup()
        
        [dateLabel, eventLabel, backgroundImageView, verticalStackview].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        eventLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        verticalStackview.axis = .vertical
        verticalStackview.alignment = .trailing
    }
    
    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackview)
        contentView.addSubview(eventLabel)
        verticalStackview.addArrangedSubview(timeRemainingStackview)
        verticalStackview.addArrangedSubview(UIView())
        verticalStackview.addArrangedSubview(dateLabel)
    }
    
    private func setupLayout() {
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        backgroundImageView.pinToSuperviewEdges([.left, .right, .top])
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackview.pinToSuperviewEdges([.top, .bottom, .right], constant: 15)
        eventLabel.pinToSuperviewEdges([.bottom, .left], constant: 15)
    }
    
    public func update(with viewModel: EventCellViewModel) {
        if let timeRemainingViewModel = viewModel.timeRemainingViewModel {
            timeRemainingStackview.update(with: timeRemainingViewModel)
        }
        
        dateLabel.text  = viewModel.dateText
        eventLabel.text = viewModel.eventName
        viewModel.loadImage { [unowned self] image in
            backgroundImageView.image = image
        }
    }
}
