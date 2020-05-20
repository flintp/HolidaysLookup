//
//  HolidayDetailsModelController.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 16/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

class HolidayDetailsModelController {
    private(set) var model: Holiday
    var getName: String {
        model.name
        
    }
    var getDate: String {
        return "\(model.date.day)/\(model.date.month)/\(model.date.year)"
        
    }
    var getDescription: String {
        model.description
        
    }
    var getType: String? {
        model.type.first
    }
    
    //MARK: - Initialization
    init(model: Holiday) {
        self.model = model
    }
}
