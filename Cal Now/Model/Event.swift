//
//  Event.swift
//  Cal Now
//
//  Created by Erik Fisher on 4/11/19.
//  Copyright © 2019 Darke Fisher. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    enum EventType: String, CaseIterable {
        case Academic, Sport, Concert
    }
    
    var start: Date?
    var end: Date?
    var image: UIImage?
    var eventLink: String?
    var description: String?
    var type: EventType
    static public var typesString: [String] {
        get {
            var result = [String]()
            for elem in EventType.allCases {
                result.append(elem.rawValue)
            }
            return result
        }
    }
    
    init(start: Date?, end: Date?, image: UIImage?, eventLink: String?, type: EventType, description: String?) {
        if let strt = start {
            self.start = strt
        }
        if let ed = end {
            self.end = ed
        }
        if let img = image {
            self.image = img
        }
        
        self.type = type
        if let link = eventLink {
            self.eventLink = link
        }
        if let desc = description {
            self.description = desc
        }
    }
    
}
