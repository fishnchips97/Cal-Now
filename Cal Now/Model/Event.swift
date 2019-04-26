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
    
    enum EventType {
        case Academic, Sport, Concert
    }
    
    var date: Date?
    var image: UIImage?
    var eventLink: String?
    var description: String?
    var type: EventType
    
    init(date: Date?, image: UIImage?, eventLink: String?, type: EventType, description: String?) {
        if let dat = date {
            self.date = dat
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
