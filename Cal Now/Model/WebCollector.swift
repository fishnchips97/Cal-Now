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
    
    var websites = [String:String]()
    
    init() {
        websites["https://inforib.com/edu/uc-berkeley-academic-calendar"] = ""
        websites["https://www.thegreektheatreberkeley.com"] = ""
        for sport in sports.allCases {
            websites["https://calbears.com/schedule.aspx?path=\(sport.rawValue)"] = ""
        }
    }
    
    func parseWebsites() {
        for site in websites {
            if site.key.contains("inforib.com") {
                print("inforib")
            } else if site.key.contains("greektheatre") {
                print("theatre")
            } else if site.key.contains("calbears.com"){
                print("go bears")
            }
            print(site.value)
        }
    }
    
    
}
