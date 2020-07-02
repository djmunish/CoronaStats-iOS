//
//  ErrorMessage.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {

    case unableToComplete = "Unable able to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again later."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToGetDate = "The date could not be retrieved."

}
