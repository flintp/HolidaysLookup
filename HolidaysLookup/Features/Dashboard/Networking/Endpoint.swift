//
//  Endpoint.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 15/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

//MARK: - Base Struct

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL { get }
}

extension Endpoint {
    var queryItems: [URLQueryItem] {
        return []
    }
}

//MARK: - Custom Implementation

struct HolidaysEndpoint: Endpoint {
    struct CommonAttributes {
        static let API_KEY = "57ccc8a2961f541befee9785fbe21c9fe02085da"
        static let basePath = "/api/v2/holidays"
    }
    
    let path: String
    let queryItems: [URLQueryItem]
    var url: URL {
        let commonQueryItems = [URLQueryItem(name: "api_key", value: CommonAttributes.API_KEY)]
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "calendarific.com"
        components.path = path
        components.queryItems = commonQueryItems + queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL component: \(components)")
        }
        
        return url
    }
}

extension HolidaysEndpoint {
    static func searchForHolidaysOfCurrentYear(matching query: String) -> Self {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        return HolidaysEndpoint(path: CommonAttributes.basePath,
                                queryItems: [
                                    URLQueryItem(name: "country", value: query),
                                    URLQueryItem(name: "year", value: currentYear)
        ])
    }
}


