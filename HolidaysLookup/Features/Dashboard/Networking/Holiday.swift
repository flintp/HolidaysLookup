//
//  Holiday.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 08/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var meta: ResponseCode
    var response: Holidays
}

struct ResponseCode: Decodable {
    var code: Int
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var description: String
    var date: DateInfo
    var type: [String]
}

struct DateInfo: Decodable {
    var iso: String
    var datetime: DateTime
}

struct DateTime: Decodable {
    var year: Int
    var month: Int
    var day: Int
}
