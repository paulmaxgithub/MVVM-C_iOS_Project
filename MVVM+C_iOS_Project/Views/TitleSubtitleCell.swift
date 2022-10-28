//
//  TitleSubtitleCell.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 18.10.22.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    
    private let titleLabel          = UILabel()
    public let subtitleTextField    = UITextField()
    private let verticalStackView   = UIStackView()
    private let photoImageView      = UIImageView()
    private let datePicker          = UIDatePicker()
    private let toolbar             = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done,
                                     target: self,
                                     action: #selector(tappedDone))
        return button
    }()
    
    private let padding: CGFloat = 15
    
    private var viewModel: TitleSubtitleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placehoder
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePicker
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        photoImageView.isHidden = viewModel.type != .image
        photoImageView.image = viewModel.image
        subtitleTextField.isHidden = viewModel.type == .image
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        verticalStackView.axis = .vertical
        [titleLabel, subtitleTextField, verticalStackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        toolbar.setItems([doneButton], animated: false)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
        } else {
            datePicker.datePickerMode = .date
        }
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.masksToBounds = true
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func tappedDone() {
        viewModel?.update(datePicker.date)
    }
}
