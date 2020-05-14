//
//  HolidayRequest.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 09/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "57ccc8a2961f541befee9785fbe21c9fe02085da"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
    }
}
