//
//  EventCellViewModel.swift
//  MVVM+C_iOS_Project
//
//  Created by PaulmaX on 25.10.22.
//

import UIKit

struct EventCellViewModel {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    private var cacheKey: String { event.objectID.description }
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    private let event: Event
    init(_ event: Event) {
        self.event = event
    }
    
    var timeRemainingString: [String] {
        let date = Date()
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
}
