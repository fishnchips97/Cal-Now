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
    
    enum scraperType {
        case academic, sport, entertainment
    }
    
    enum sports : String, CaseIterable {
        case baseball, softball, track, mten, wten
    }
    
    let url: String
    let numSources = sports.allCases.count + 2
    
    init(type: scraperType) {
        switch type {
        case .academic:
            url = "https://inforib.com/edu/uc-berkeley-academic-calendar"
        case .sport:
            url = "https://calbears.com/schedule.aspx?path=baseball"
        case .entertainment:
            url = "http://www.thegreektheatreberkeley.com"
        
        }
    }
    
    
    
    
}
