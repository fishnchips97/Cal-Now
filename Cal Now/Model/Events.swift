//
//  Events.swift
//  Cal Now
//
//  Created by Erik Fisher and Mangesh Darke on 4/11/19.
//  Copyright © 2019 Darke Fisher. All rights reserved.
//

import Foundation

class Events {
    var Events = [Event]()
    var dateEvents = [Date:Event]()
    var categories = [Event.EventType]()
    
    func testTableView() {
        let testEvent = Event(start: Date(), end: Date(), image: #imageLiteral(resourceName: "oski"), eventLink: " ", type: .Academic, description: "This is a test", title: "TEST")
        Events.append(testEvent)
    }
}


