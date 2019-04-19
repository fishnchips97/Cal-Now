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
        websites["http://www.thegreektheatreberkeley.com"] = ""
        for sport in sports.allCases {
            websites["https://calbears.com/schedule.aspx?path=\(sport.rawValue)"] = ""
        }
    }
    
    
    
    
}
