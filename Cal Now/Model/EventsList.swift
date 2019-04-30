//
//  EventsList.swift
//  Cal Now
//
//  Created by Erik Fisher on 4/27/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import Foundation

var EventsList = [Event]()

var categories: [String] {
    get {
        return Event.typesString + WebCollector.sportsStrings
    }
}
