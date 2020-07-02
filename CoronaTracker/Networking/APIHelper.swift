//
//  APIHelper.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import Foundation

class APIHelper {

    static let shared = APIHelper()
    
    private init() {}

    func downloadData(forCountryCode code: String?,
                      completion: @escaping (Result<CountryData, ErrorMessage>) -> ()) {

        var url: URL
        if let countryCode = code {
            url = URL(string: "https://disease.sh/v3/covid-19/countries/\(countryCode)")!
        }
        else {
            url = URL(string: "https://disease.sh/v3/covid-19/all")!
        }

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error)
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let covidData = try JSONDecoder().decode(CountryData.self, from: data)
                completion(.success(covidData))
            }
            catch {
                print(error)
                completion(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}
