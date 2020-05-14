
//
//  DataLoader.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 14/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

class DataLoader {
    func loadData (forRequest request: HolidayRequest, completion: @escaping(Result<[HolidayDetail], RequestError>) -> Void ) {
        let dataTask = URLSession.shared.dataTask(with: request.resourceURL) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                self.handleClientError(error)
            }
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidaysDetails = holidaysResponse.response.holidays
                completion(.success(holidaysDetails))
                
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    private func handleClientError(_ error: Error) {
        print("Error encountered during network request: \(error.localizedDescription)")
    }
    
}
