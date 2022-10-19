//
//  TitleSubtitleCellViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 18.10.22.
//

import Foundation

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text, date, image
    }
    
    private(set) var title: String
    private(set) var subtitle: String
    private(set) var placehoder: String
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
       return dateFormatter
    }()
    
    private(set) var type: CellType
    
    private(set) var onCellUpdate: () -> Void = {}
    
    init(title: String, subtitile: String, placeholder: String, type: CellType, onCellUpdate: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitile
        self.placehoder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    public func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    public func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate()
    }
}
