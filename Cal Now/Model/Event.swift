//
//  Event.swift
//  Cal Now
//
//  Created by Erik Fisher and Mangesh Darke on 4/11/19.
//  Copyright © 2019 Darke Fisher. All rights reserved.
//

import Foundation
import UIKit

class Event {

    enum EventType: String, CaseIterable {
        case Academic, Sport, Concert
    }

    enum Sport : String, CaseIterable {
        case Baseball,
        Softball,
        Track,
        mten,
        wten
    }

    var start: Date?
    var end: Date?
    var image: UIImage?
    var eventLink: String?
    var description: String?
    var type: EventType
    var sportType: Sport?
    static public var eventTypeStrings: [String] {
        get {
            var result = [String]()
            for elem in EventType.allCases {
                result.append(elem.rawValue)
            }
            return result
        }
    }
    static public var sportTypeStrings: [String] {
        get {
            var result = [String]()
            for elem in Sport.allCases {
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

        if let link = eventLink {
            self.eventLink = link
        }

        self.type = type
        if type.rawValue == EventType.Sport.rawValue {

            if let desc = description {
                self.sportType = Sport.init(rawValue: desc.prefix(upToString: ":"))
                self.description = desc.suffix(afterString: ": ")

            }
        } else {
            if let desc = description {
                self.description = desc
            }
        }

    }

    func printEvent() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm aa"
        if let strt = self.start {
            let start = formatter.string(from: strt)
            print("Start: \(start)")
        } else {
            print("Start: nil")
        }
        if let nd = self.end {
            let end = formatter.string(from: nd)
            print("End: \(end)")
        } else {
            print("End: nil")
        }

        print("EventLink: \(self.eventLink ?? "nil")")
        print("Description: \(self.description ?? "nil")")

        print("Type: \(self.type.rawValue)")
        if self.type == .Sport {
            if let sprt = self.sportType {
                print("Sport Type: \(sprt)")
            }
        }
    }

}
