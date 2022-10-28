//
//  Date+Ext.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 28.10.22.
//

import Foundation

extension Date {
    func timeRamaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
}
