//
//  CountryData.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import Foundation

struct CountryData: Codable {
    let country: String?
    let updated: Int
    let cases: Int
    let deaths: Int
    let recovered: Int
    let countryInfo: CountryInfo?
}

struct CountryInfo: Codable {
    let lat: Double
    let long: Double
}
