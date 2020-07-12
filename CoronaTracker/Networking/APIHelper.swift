//
//  APIHelper.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import Foundation
import SystemConfiguration

class APIHelper {

    static let shared = APIHelper()
    
    private init() {}

    func downloadData(forCountryCode code: String?,
                      completion: @escaping (Result<CountryData, ErrorMessage>) -> ()) {
        
        if !connectedToNetwork() {
            completion(.failure(.noInternet))
        }
        else {
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

    private func connectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
}
