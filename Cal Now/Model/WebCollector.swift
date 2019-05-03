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
    
    var websites = [String]()
    
    init() {
        websites.append("https://inforib.com/edu/uc-berkeley-academic-calendar")
        websites.append("https://www.thegreektheatreberkeley.com/events/")
        for sport in Event.sportTypeStrings {
            websites.append("https://calbears.com/schedule.aspx?path=\(sport)")
        }
    }
    
    var failedLoads = 0
    var loads = 0
    func parseWebsite(html: String, site: String) {
//        print(html)
//        var replaceMe = [Event]()
        loads += 1
        
        
        if site.contains("inforib.com") {
            print("academic")
            academicParse(htmlToParse: html)
            
                
                
        } else if site.contains("greektheatre") {
            print("theater")
            theaterParse(htmlToParse: html)
//            print(html)
        } else if site.contains("calbears.com"){
            print("go bears")
            let sportString = site.suffix(afterString: "https://calbears.com/schedule.aspx?path=")

            sportParse(htmlToParse: html, sport: sportString)
        }
        if (loads - failedLoads) == websites.count {
            print("done")
//            for event in EventsList {
////                print()
////                event.printEvent()
//            }
            print("\(EventsList.count) events")
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
func sportParse(htmlToParse: String, sport: String) {
//    print(htmlToParse)

    var eventStrings = htmlToParse.wordsBetween(
        start: "opponent-date",
        end: "Watch</a>"
    )
//    eventStrings += htmlToParse.wordsBetween(
//        start: "opponent-date",
//        end: "Recap</a>"
//    )

    for elem in eventStrings {
//        print(elem)

        let dateAndTime = elem.wordsBetween(start: "<span>", end: "</span>")
        let vs = elem.wordsBetween(start: "<span class=\"sidearm-schedule-game-home\">", end: "</span>")
        let at = elem.wordsBetween(start: "<span class=\"sidearm-schedule-game-away\">", end: "</span>")
        let possibleTitles = elem.wordsBetween(start: "target=\"_blank\">", end: "</a>")
//        var possibleYears = elem.wordsBetween(start: "on ", end: "\">")
//        possibleYears = possibleYears.filter({ (str) -> Bool in
//            str.contains(subString: " at ")
//        })
//        for n in possibleYears {
//            print(n)
//        }
        
        if dateAndTime.count > 1 && possibleTitles.count > 0 {
            var dateString = dateAndTime[0]
            dateString = dateString.prefix(upToString: " (")
            let time = dateAndTime[1]
            var title = possibleTitles[0]
            if !vs.isEmpty {
                title = vs[0] + " " + title
            } else if !at.isEmpty {
                title = at[0] + " " + title
            }
            print("date: \(dateString)")
            print("time: \(time)")
            print("\(sport): \(title)")
            print()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd, MMM yyyy"
//            let dateString = "\(day), \(monthYear)"
            
//            print(dateString)
            
//            let date = formatter.date(from: dateString)
//            let sportEnum = Event.sports.init(rawValue: sportString)
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
                
                if temp.count > 1 {
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

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
