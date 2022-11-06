//
//  EditEventViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 3.11.22.
//

import Foundation
import UIKit

final class EditEventViewModel {
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private var nameCellViewModel:  TitleSubtitleCellViewModel?
    private var dateCellViewModel:  TitleSubtitleCellViewModel?
    private var imageCellViewModel: TitleSubtitleCellViewModel?
    
    //TODO: - Check with retain cicle (weak value) ⚠️
    public weak var coordinator: EditEventCoordinator?
    
    private(set) var cells: [EditEventViewModel.Cell] = []
    
    public var onUpdate: () -> Void = {}
    
    public let title = "Edit"
    
    private let eventsCellBuilder:  EventsCellBuilder
    private let eventService:       EventServiceProtocol
    private let event:              Event
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(eventsCellBuilder: EventsCellBuilder, eventService: EventServiceProtocol = EventService(), event: Event) {
        self.eventsCellBuilder = eventsCellBuilder
        self.eventService = eventService
        self.event = event
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
        
        eventService.perform(.update(event), EventService.EventInputData(name: name, date: date, image: image))
        coordinator?.didFinishUpdateEvent()
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

private extension EditEventViewModel {
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
        
        if let name = event.name,
           let date = event.date,
           let imageData = event.image,
           let image = UIImage(data: imageData) {
            nameCellViewModel?.update(name)
            dateCellViewModel?.update(date)
            imageCellViewModel?.update(image)
        }
    }
}
