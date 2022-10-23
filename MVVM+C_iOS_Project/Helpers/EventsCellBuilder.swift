//
//  EventsCellBuilder.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 23.10.22.
//

import Foundation

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType,
                                        onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name", subtitile: "",
                placeholder: "Add Your Name...",
                type: .text,
                onCellUpdate: onCellUpdate)
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date", subtitile: "",
                placeholder: "Select a Date...",
                type: .date,
                onCellUpdate: onCellUpdate)
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background", subtitile: "",
                placeholder: "Select a Date...",
                type: .image,
                onCellUpdate: onCellUpdate)
        }
    }
}
