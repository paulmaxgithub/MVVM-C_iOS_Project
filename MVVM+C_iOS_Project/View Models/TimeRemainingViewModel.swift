//
//  TimeRemainingViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 2.11.22.
//

import UIKit

final class TimeRemainingViewModel {
    
    enum Mode {
        case cell, detail
    }
    
    public var fontSize: CGFloat {
        switch mode {
        case .cell: return 25
        case .detail: return 60
        }
    }
    
    public var alignment: UIStackView.Alignment {
        switch mode {
        case .cell: return .trailing
        case .detail: return .center
        }
    }
    
    public let timeRemainingParts: [String]
    private let mode: Mode
    
    init(timeRemainingParts: [String], mode: Mode) {
        self.timeRemainingParts = timeRemainingParts
        self.mode = mode
    }
}
