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
        websites.append("https://www.thegreektheatreberkeley.com")
        for sport in sports.allCases {
            websites.append("https://calbears.com/schedule.aspx?path=\(sport.rawValue)")
        }
    }
    
    func parseWebsite(html: String) {
//        print(html)
//        var replaceMe = [Event]()
        
        
        var values = [String]()
        if html.contains("inforib.com") {
            print("academic")
            
        values = html.wordsBetween(start: "<p>", end: "</p>")
        
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
        var tempEvent : Event
        for elem in result {
            if !elem.contains(subString: " - ") {
                let tempDescription = elem.prefix(upToString: ", ")
//                print(tempDescription)
                let tempLink = elem.suffix(afterString: ", ")
//                print(tempLink)
                tempEvent = Event(start: nil, end: nil, image: nil, eventLink: tempLink, type: .Academic, description: tempDescription)
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
                    tempEvent = Event(start: date1, end: date2, image: nil, eventLink: nil, type: .Academic, description: description)
                } else {
                    let date1str = rest
                    formatter.dateFormat = "EEEE, MMMM d, yyyy"
                    let date1 = formatter.date(from: date1str)
                    tempEvent = Event(start: date1, end: nil, image: nil, eventLink: nil, type: .Academic, description: description)
                }
            }

//            print(elem)
//            replaceMe.append(tempEvent)
        }
//        print(replaceMe)
            
            
        } else if html.contains("greektheatre") {
            print("theater")
        } else if html.contains("calbears.com"){
            print("go bears")
        }
//        if html != "" {
//            print("good")
//        } else {
//            print("uh")
//        }
        
    }
    
    
}



extension String {
    
    func contains(subString: String) -> Bool {
        var tempSubString = subString
        for char in self {
            if char == Array(tempSubString)[0] {
                if tempSubString.count == 1 {
                    return true
                }
                tempSubString = String(tempSubString.suffix(tempSubString.count - 1))
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
        for char in self {
            
            if char == Array(tempStart)[0] {
                if tempStart.count == 1 {
                    tempStart = ""
                } else {
                    tempStart = String(tempStart.suffix(tempStart.count - 1))
                }
                
            } else {
                tempStart = start
            }
            if char == Array(tempEnd)[0] {
                
                if tempEnd.count == 1 {
                    tempEnd = ""
                } else {
                    tempEnd = String(tempEnd.suffix(tempEnd.count - 1))
                }
                
                
            } else {
                tempEnd = end
            }
            if tempStart == "" {
                
                constructingString = true
                tempStart = start
            }
            if constructingString {
                temp += "\(char)"
            }
            if tempEnd == "" {
                constructingString = false
                if temp != "" {
                    temp = String(temp.suffix(temp.count - 1))
                    temp = String(temp.prefix(temp.count - end.count))
                    result.append(temp)
                    temp = ""
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
