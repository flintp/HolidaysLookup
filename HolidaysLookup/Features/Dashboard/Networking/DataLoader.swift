
//
//  DataLoader.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 14/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

enum DataLoadError: Error {
    case invalidURL
    case dataReturnedIsEmpty
    case canNotProcessData
}

class DataLoader {
    //MARK: - Private
    private func handleClientError(_ error: Error) {
        print("Error encountered during network request: \(error.localizedDescription)")
    }
    
    //MARK: - Public
    func request(_ endpoint: Endpoint, completion: @escaping(Result<[HolidayDetail], DataLoadError>) -> Void ) {
        
        let dataTask = URLSession.shared.dataTask(with: endpoint.url) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
            }
            
            guard let jsonData = data else {
                completion(.failure(.dataReturnedIsEmpty))
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
}
