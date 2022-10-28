//
//  EventCell.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 25.10.22.
//

import UIKit

final class EventCell: UITableViewCell {
    
    private let yearLabel           = UILabel()
    private let monthLabel          = UILabel()
    private let weekLabel           = UILabel()
    private let dayLabel            = UILabel()
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
    
    private func setupViews() {
        [yearLabel, monthLabel, weekLabel, dayLabel, dateLabel, eventLabel, backgroundImageView, verticalStackview].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        [yearLabel, monthLabel, weekLabel, dayLabel].forEach {
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }
        
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
        verticalStackview.addArrangedSubview(yearLabel)
        verticalStackview.addArrangedSubview(monthLabel)
        verticalStackview.addArrangedSubview(weekLabel)
        verticalStackview.addArrangedSubview(dayLabel)
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
        yearLabel.text  = viewModel.yearText
        monthLabel.text = viewModel.monthText
        weekLabel.text  = viewModel.weekText
        dayLabel.text   = viewModel.dayText
        dateLabel.text  = viewModel.dateText
        eventLabel.text = viewModel.eventName
        backgroundImageView.image = viewModel.backgroundImage
    }
}
