//
//  AddEventViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 17.10.22.
//

import Foundation

final class AddEventViewModel {
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    public var coordinator: AddEventCoordinator?
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    public var onUpdate: () -> Void = {}
    
    public let title = "Add"
    
    public func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubtitleCellViewModel(title: "Name", subtitile: "", placeholder: "Add Your Name...", type: .text, onCellUpdate: {})),
            .titleSubtitle(TitleSubtitleCellViewModel(title: "Date", subtitile: "", placeholder: "Select a Date...", type: .date, onCellUpdate: { [weak self] in
                self?.onUpdate()
            })),
            .titleSubtitle(TitleSubtitleCellViewModel(title: "Background", subtitile: "", placeholder: "Select a Date...", type: .image, onCellUpdate: { [weak self] in
                self?.onUpdate()
            }))
            
        ]
        onUpdate()
    }
    
    public func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    public func numberOfRows() -> Int {
        return cells.count
    }
    
    public func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    public func tappedDone() {
        //TODO: ⚠️
        coordinator?.dismissAddEvent()
    }
    
    public func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
}
