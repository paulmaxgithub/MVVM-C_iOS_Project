//
//  EventCellViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 25.10.22.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
    public static let imageCache = NSCache<NSString, UIImage>()
    private var cacheKey: String { event.objectID.description }
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    private let date = Date()
    
    public var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event.date,
              let timeRemainingParts = date.timeRamaining(until: eventDate)?.components(separatedBy: ",")
        else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
    }
    
    private let event: Event
    init(_ event: Event) {
        self.event = event
    }
    
    var timeRemainingString: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRamaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String {
        guard let eventDate = event.date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String {
        guard let name = event.name else { return "" }
        return name
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = event.image, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    public func didSelect() {
        onSelect(event.objectID)
    }
}
