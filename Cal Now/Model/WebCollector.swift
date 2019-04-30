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
    
    var websites = [String]()
    
    init() {
        websites.append("https://inforib.com/edu/uc-berkeley-academic-calendar")
        websites.append("https://www.thegreektheatreberkeley.com")
        for sport in sports.allCases {
            websites.append("https://calbears.com/schedule.aspx?path=\(sport.rawValue)")
        }
    }
    
    func parseWebsite(html: String) {
        if html.contains("inforib.com") {
            var temp = html.split(separator: "<")
            temp = temp.filter({$0.contains("<p>")})
//            print(html)
            print(temp)
            
            temp.removeSubrange(temp.startIndex..<temp.startIndex)
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
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
