//
//  EventCellViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 25.10.22.
//

import UIKit

struct EventCellViewModel {
    
    var yearText: String {
        "1 year"
    }
    
    var monthText: String {
        "2 months"
    }
    
    var weekText: String {
        "2 weeks"
    }
    
    var dayText: String {
        "2 days"
    }
    
    var dateText: String {
        "25 Mar 2020"
    }
    
    var eventName: String {
        "Barbados"
    }
    
    var backgroundImage: UIImage {
        #imageLiteral(resourceName: "newYearImage")
    }
}
