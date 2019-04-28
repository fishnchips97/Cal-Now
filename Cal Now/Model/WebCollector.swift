//
//  academicScraper.swift
//  Cal Now
//
//  Created by Erik Fisher on 4/11/19.
//  Copyright © 2019 Darke Fisher. All rights reserved.
//

import Foundation
import WebKit

class WebCollector {
    
    enum format {
        case Academic, Sport, Concert
    }
    
    enum sports : String, CaseIterable {
        case baseball,
             softball,
             track,
             mten,
             wten
    }
    static public var sportsStrings: [String] {
        get {
            var result = [String]()
            for elem in sports.allCases {
                result.append(elem.rawValue)
            }
            return result
        }
    }
    
    var websites = [String]()
    
    init() {
        websites.append("https://inforib.com/edu/uc-berkeley-academic-calendar")
        websites.append("https://www.thegreektheatreberkeley.com/events/")
        for sport in sports.allCases {
            websites.append("https://calbears.com/schedule.aspx?path=\(sport.rawValue)")
        }
    }
    
    var failedLoads = 0
    var loads = 0
    func parseWebsite(html: String) {
//        print(html)
//        var replaceMe = [Event]()
        loads += 1
        
        
        if html.contains("inforib.com") {
            print("academic")
            academicParse(htmlToParse: html)
            
                
                
        } else if html.contains("greektheatre") {
            print("theater")
            theaterParse(htmlToParse: html)
//            print(html)
        } else if html.contains("calbears.com"){
            print("go bears")
//            sportParse(htmlToParse: html)
        }
        if (loads - failedLoads) == websites.count {
            print("done")
            for event in EventsList {
//                print()
//                event.printEvent()
            }
        }
        
    }
    
    
}

func academicParse(htmlToParse: String) {
    var values = [String]()
    values = htmlToParse.wordsBetween(start: "<p>", end: "</p>")
    
    values = values.filter { (str) -> Bool in
        str.contains(subString: "January") ||
            str.contains(subString: "February") ||
            str.contains(subString: "March") ||
            str.contains(subString: "April") ||
            str.contains(subString: "May") ||
            str.contains(subString: "June") ||
            str.contains(subString: "July") ||
            str.contains(subString: "August") ||
            str.contains(subString: "September") ||
            str.contains(subString: "October") ||
            str.contains(subString: "November") ||
            str.contains(subString: "December")
    }
    values = values.map({ (str) -> String in
        str.replace(subString: "&#8211;", replacement: "-")
    })
    values = values.map({ (str) -> String in
        str.replace(subString: "<br />", replacement: "")
    })
    values = values.map({ (str) -> String in
        str.replace(subString: " &amp; ", replacement: "-")
    })
    
    var temp = [Substring]()
    var result = [String]()
    for val in values {
        temp = val.split(separator: "\n")
        for str in temp {
            result.append(String(str))
        }
    }
    result = Array(Set(result))
    var newEvent : Event
    for elem in result {
//        print(elem)
        if !elem.contains(subString: " - ") {
            let tempDescription = elem.prefix(upToString: ", ")
            let tempLink = elem.suffix(afterString: ", ")
            newEvent = Event(start: nil, end: nil, image: nil, eventLink: tempLink, type: .Academic, description: tempDescription)
        } else {
            let description = elem.prefix(upToString: " - ")
            let rest = elem.suffix(afterString: " - ")
            let formatter = DateFormatter()
            if rest.contains(subString: "-") {
                var date1str = rest.prefix(upToString: "-")
                let date2str = rest.suffix(afterString: "-")
                date1str += ", " + String(date2str.suffix(4))
                formatter.dateFormat = "EEEE, MMMM d, yyyy"
                let date1 = formatter.date(from: date1str)
                let date2 = formatter.date(from: date2str)
                newEvent = Event(start: date1, end: date2, image: nil, eventLink: nil, type: .Academic, description: description)
            } else {
                let date1str = rest
                formatter.dateFormat = "EEEE, MMMM d, yyyy"
                let date1 = formatter.date(from: date1str)
                newEvent = Event(start: date1, end: nil, image: nil, eventLink: nil, type: .Academic, description: description)
            }
        }
        EventsList.append(newEvent)
        
        //            print(elem)
        //            replaceMe.append(tempEvent)
    }
    //        print(replaceMe)
}
func theaterParse(htmlToParse: String) {
    let monthsWithEvents = htmlToParse.wordsBetween(start: "<p class=\"text-center event-month-header\">", end: "</ul>")
    for text in monthsWithEvents {
        let elem = text.replace(subString: "&amp;", replacement: "&")
        let monthYear = elem.prefix(upToString: "</p>")
//        print(monthYear)
        let htmlEvents = elem.wordsBetween(start: "<li class=\"em-entry-list-item\">", end: "</li>")
        for eventString in htmlEvents {
            let day1 = eventString.suffix(afterString: "<span class=\"em-entry-day\">")
            let day = day1.prefix(upToString: "</span>")
//            print(day)
            
            let title1 = eventString.suffix(afterString: "<h3 class=\"em-entry-title\">")
            let title2 = title1.suffix(afterString: ">")
            let title = title2.prefix(upToString: "</a>")
//            print(title)
            
            let link1 = title1.prefix(upToString: "\">")
            let link = link1.suffix(afterString: "<a href=\"")
//            print(link)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd, MMM yyyy"
            let dateString = "\(day), \(monthYear)"
            
            let date = formatter.date(from: dateString)
            let newEvent = Event(start: date, end: nil, image: nil, eventLink: link, type: .Concert, description: title)
            EventsList.append(newEvent)
        }
    }
    
}
func sportParse(htmlToParse: String) {
//    print(htmlToParse)

    let eventStrings = htmlToParse.wordsBetween(
        start: "opponent-date",
        end: "game-links"
    )

    for elem in eventStrings {
//        print(elem)
        
        let dayAndTime = elem.firstWordBetween(
            start: "<span>",
            end: " PT"
        )
        let day = dayAndTime.prefix(upToString: " (")
        let time = dayAndTime.suffix(afterString: "<span>")
        if !day.isEmpty {
            print(day)
        }
        if !time.isEmpty {
            print(time)
        }
        let title = elem.firstWordBetween(start: "target=\"_blank\">", end: "</a>")
        if !title.isEmpty {
            print(title)
        }
        
        
    }
}

extension String {
    
    func contains(subString: String) -> Bool {
        var tempSubString = subString
        for char in self {
            if char == tempSubString.removeFirst() {
                if tempSubString.isEmpty {
                    return true
                }
            } else {
                tempSubString = subString
            }
        }
        return false
    }
    
    func replace(subString:String, replacement: String) -> String {
        var result = ""
        var tempSubString = subString
        for char in self {
            result += "\(char)"
            if char == Array(tempSubString)[0] {
                if tempSubString.count == 1 {
                    result = String(result.prefix(result.count - subString.count))
                    result += replacement
                    tempSubString = subString
                } else {
                    tempSubString = String(tempSubString.suffix(tempSubString.count - 1))
                }
                
            } else {
                tempSubString = subString
            }
        }
        return result
    }
    
    func wordsBetween(start: String, end: String) -> [String] {
        var temp = ""
        var result = [String]()
        var tempStart = start
        var tempEnd = end
        var constructingString = false
//        print(self.count)
        for char in self {
            
            if char != tempStart.removeFirst() {
                tempStart = start
            }
            if char != tempEnd.removeFirst() {
                tempEnd = end
            }
            
            if tempStart.isEmpty {
                constructingString = true
                tempStart = start
            }
            if constructingString {
                temp += "\(char)"
            }
            if tempEnd.isEmpty {
                constructingString = false
                if !temp.isEmpty {
                    temp.removeFirst()
                    temp = "\(temp.prefix(temp.count - end.count))"
                    result.append(temp)
                    temp = ""
                }
                
                tempEnd = end
            }
            
        }
        return result
    }
    
    func firstWordBetween(start: String, end: String) -> String {
        var temp = ""
        var result = ""
        var tempStart = start
        var tempEnd = end
        var constructingString = false
        //        print(self.count)
        for char in self {
            
            if char != tempStart.removeFirst() {
                tempStart = start
            }
            if char != tempEnd.removeFirst() {
                tempEnd = end
            }
            
            if tempStart.isEmpty {
                constructingString = true
                tempStart = start
            }
            if constructingString {
                temp += "\(char)"
            }
            if tempEnd.isEmpty {
                constructingString = false
                if !temp.isEmpty {
                    temp.removeFirst()
                    result = "\(temp.prefix(temp.count - end.count))"
                    return result
                }
                
                tempEnd = end
            }
            
        }
        return result
    }
    
    func prefix(upToString limit: String) -> String {
        var tempLimit = limit
        var result = ""
        for char in self {
            result += "\(char)"
            if char == Array(tempLimit)[0] {
                if tempLimit.count == 1 {
                    result = String(result.prefix(result.count - limit.count))
                    return result
                }
                tempLimit = String(tempLimit.suffix(tempLimit.count - 1))
            } else {
                tempLimit = limit
            }
        }
        return self
    }
    
    func suffix(afterString limit: String) -> String {
        var tempLimit = limit
        var result = ""
        for char in self {
            result += "\(char)"
            if char == Array(tempLimit)[0] {
                if tempLimit.count == 1 {
                    result = String(self.suffix(self.count - result.count))
                    return result
                }
                tempLimit = String(tempLimit.suffix(tempLimit.count - 1))
            } else {
                tempLimit = limit
            }
        }
        return self
    }
    
    func subStringCount(subString: String) -> Int {
        
        var tempSubString = subString
        var count = 0
        for char in self {
            if char == Array(tempSubString)[0] {
                if tempSubString.count == 1 {
                    count += 1
                    tempSubString = subString
                }
                tempSubString = String(tempSubString.suffix(tempSubString.count - 1))
            } else {
                tempSubString = subString
            }
        }
        return count
    }

}
