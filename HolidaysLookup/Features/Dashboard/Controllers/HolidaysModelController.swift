//
//  HolidaysModelController.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 15/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

class HolidaysModelController {
    //MARK: - Properties
    private var model: HolidaysModel
    
    var numberOfMonths: Int {
        return model.numberOfMonths
    }
    var totalNumberOfHolidays: Int {
        return model.allHolidays.count
    }
    
    //MARK: - Initialization
    init(model: HolidaysModel) {
        self.model = model
    }
    
    //MARK: - Public API
    func transform(rawModel: [HolidayDetail]) {
        var newHolidaysModel = [Holiday]()
        
        
        for holidayDetail in rawModel {
            let holidayDate = Holiday.HolidayDate(year: holidayDetail.date.datetime.year,
                                                  month: holidayDetail.date.datetime.month,
                                                  day: holidayDetail.date.datetime.day)
            
            let newHoliday = Holiday(date: holidayDate,
                                     name: holidayDetail.name,
                                     description: holidayDetail.description,
                                     type: holidayDetail.type)
            newHolidaysModel.append(newHoliday)
        }
        
        model = HolidaysModel(holidays: newHolidaysModel)
    }
    
    func deleteModel() {
        model = HolidaysModel()
    }
    
    func numberOfDaysForMonth(_ month:Int) -> Int {
        return model.allHolidaysSortedByMonth[month].count
    }
    
    func formattedDateText(for indexPath: IndexPath) -> String {
        let holiday = model.allHolidaysSortedByMonth[indexPath.section][indexPath.row]
        return "\(holiday.date.year)/\(holiday.date.month)/\(holiday.date.day)"
    }
    
    func holidayName(for indexPath: IndexPath) -> String {
        let holiday = model.allHolidaysSortedByMonth[indexPath.section][indexPath.row]
        
        return holiday.name
    }
    
    func getIndividualHoliday(for indexPath: IndexPath) -> Holiday {
        let holiday = model.allHolidaysSortedByMonth[indexPath.section][indexPath.row]
        return holiday
    }
}
