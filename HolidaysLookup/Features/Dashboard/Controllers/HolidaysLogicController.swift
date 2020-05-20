//
//  HolidaysLogicController.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 14/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

class HolidaysLogicController {
    //MARK: - Properties
    private let dataloader = DataLoader()
    
    //MARK: - Public
    func loadCurrentState(usingSearchQuery query: String, then handler: @escaping (ViewState<[HolidayDetail]>) -> Void) {
        let endpoint = HolidaysEndpoint.searchForHolidaysOfCurrentYear(matching: query)
        dataloader.request(endpoint) { result in
            switch result {
            case .failure(let error):
                handler(.failed(error))
            case .success(let holidays):
                handler(.presenting(holidays))
            }
        }
    }
    
}
