//
//  Extensions.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import UIKit
import SwiftUI

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Array {
    func chunked(into size:Int) -> [[Element]] {
        
        var chunkedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                chunkedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                chunkedArray.append(Array(self[index - 1..<index]))
            }
        }
        
        return chunkedArray
    }
}

extension View {
    func displayString(countryData: CountryData?) -> [ResultModel]? {
        guard let data = countryData else {
            return nil
        }

        let recoveryPer = percentageCalculator(data)

        let active = ResultModel(title: "Active Cases",
                                 result: String(data.cases.withCommas()),
                                 bgColor: Color.blue)
        let deaths = ResultModel(title: "Deaths",
                                 result: String(data.deaths.withCommas()),
                                 bgColor: Color.red)
        let recovered = ResultModel(title: "Recovered",
                                    result: String(data.recovered.withCommas()),
                                    bgColor: Color.green)
        let recoveryRate = ResultModel(title: "Recovery Rate",
                                       result: String(recoveryPer) + " %",
                                       resultPercentage: recoveryPer,
                                       bgColor: getColorForThePercentage(recoveryPer),
                                       isProgressBar: true
                                       )
        return [active,
                deaths,
                recovered,
                recoveryRate]
    }

    private func percentageCalculator(_ countryData: CountryData) -> Double {
        Double(countryData.recovered) / Double(countryData.cases)
    }

    private func getColorForThePercentage(_ percentage: Double) -> Color {
        if percentage <= 0.02 {
            return Color.init(red: 242/255, green: 90/255, blue: 90/255)
        } else if percentage <= 0.04 {
            return Color.init(red: 247/255, green: 170/255, blue: 82/255)
        } else if percentage <= 0.05 {
            return Color.init(red: 228/255, green: 129/255, blue: 78/255)
        } else if percentage <= 0.06 {
            return Color.init(red: 106/255, green: 129/255, blue: 229/255)
        } else if percentage <= 0.07 {
            return Color.init(red: 83/255, green: 209/255, blue: 201/255)
        } else if percentage <= 0.08 {
            return Color.init(red: 78/255, green: 205/255, blue: 229/255)
        } else {
            return Color.init(red: 135/255, green: 178/255, blue: 87/255)
        }
    }
}


extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension UIImage {

    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
