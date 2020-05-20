//
//  HolidaysModel.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 15/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation


struct Holiday {
    struct HolidayDate {
        var year: Int
        var month: Int
        var day: Int
    }
    
    var date: HolidayDate
    var name: String
    var description: String
    var type: [String]
}

struct HolidaysModel {
    
    //MARK: - Properties
    let allHolidays: [Holiday]
    var allHolidaysSortedByMonth: [[Holiday]] {
        if allHolidays.isEmpty {
            return [[Holiday]]()
        }
        var holidaysByMonth: [[Holiday]] = [[Holiday]](repeating: [Holiday](), count: 12)
        
        for holiday in allHolidays {
            holidaysByMonth[holiday.date.month - 1].append(holiday)
        }
        return holidaysByMonth
    }
    var numberOfMonths: Int {
        return allHolidaysSortedByMonth.count
        
    }
    
    //MARK: - Initialization
    init(holidays: [Holiday]) {
        self.allHolidays = holidays
    }
    
    init() {
        self.init(holidays: [Holiday]())
    }
}
