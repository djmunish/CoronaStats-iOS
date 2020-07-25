//
//  ResultModel.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-12.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import Foundation
import SwiftUI


struct ResultModel: Hashable {
    let title: String
    let result: String
    var resultPercentage: Double = 0.0
    let bgColor: Color
    var isProgressBar = false
    var isWatch = false
    var country: Country?
}
