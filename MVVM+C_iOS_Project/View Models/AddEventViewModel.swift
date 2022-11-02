//
//  AddEventViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 17.10.22.
//

import UIKit

final class AddEventViewModel {
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private var nameCellViewModel:  TitleSubtitleCellViewModel?
    private var dateCellViewModel:  TitleSubtitleCellViewModel?
    private var imageCellViewModel: TitleSubtitleCellViewModel?
    
    //TODO: - Check with retain cicle (weak value) ⚠️
    public weak var coordinator: AddEventCoordinator?
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    public var onUpdate: () -> Void = {}
    
    public let title = "Add"
    
    private let eventsCellBuilder:  EventsCellBuilder
    private let coreDataManager:    CoreDataManager
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(eventsCellBuilder: EventsCellBuilder, coreDataManager: CoreDataManager = .shared) {
        self.eventsCellBuilder = eventsCellBuilder
        self.coreDataManager = coreDataManager
    }
    
    public func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    public func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    public func numberOfRows() -> Int {
        return cells.count
    }
    
    public func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    public func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let date = dateFormatter.date(from: dateString),
              let image = imageCellViewModel?.image else { return }
        
        coreDataManager.saveEvent(name: name, date: date, image: image)

        coordinator?.didFinishSaveEvent()
    }
    
    public func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else { return }
            coordinator?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image)
            }
        }
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameCellViewModel = eventsCellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = eventsCellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        imageCellViewModel = eventsCellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        cells = [.titleSubtitle(nameCellViewModel!),
                 .titleSubtitle(dateCellViewModel!),
                 .titleSubtitle(imageCellViewModel!)]
    }
}
