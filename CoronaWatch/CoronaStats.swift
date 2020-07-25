//
//  CoronaStats.swift
//  CoronaWatch Extension
//
//  Created by Ankur Sehdev on 22/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct CoronaStats: View {
    @State var countryResult: CountryData?
    @State private var listData: [ResultModel] = [ResultModel]()
    @State var countryCode: Country?

    var body: some View {
        Text("yoyo")
        .onAppear {
            self.downloadData(countryCode: self.countryCode?.code)
        }
    }
    
    func downloadData(countryCode: String?) {
        APIHelper.shared.downloadData(forCountryCode: countryCode) {  result in
            print(result)
            switch result {
            case .success(let stats):
                DispatchQueue.main.async {
                    // update our UI
                    self.countryResult = stats
                    if let data = self.displayString(countryData: stats) {
                        self.listData = data
                    }
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    private func displayString(countryData: CountryData?) -> [ResultModel]? {
        guard let data = countryData else {
            return nil
        }

        let recoveryPer = percentageCalculator(Double(data.recovered), data)
        let deathPer = percentageCalculator(Double(data.deaths), data)

        let active = ResultModel(title: "Active Cases",
                                 result: String(data.cases),
                                 bgColor: Color.blue)

        let deaths = ResultModel(title: "Deaths",
                                 result: String(data.deaths),
                                 bgColor: Color.red)

        let recovered = ResultModel(title: "Recovered",
                                    result: String(data.recovered),
                                    bgColor: Color.green)

        let recoveryRate = ResultModel(title: "Recovery Rate",
                                       result: String(recoveryPer) + " %",
                                       resultPercentage: recoveryPer,
                                       bgColor: getColorForThePercentage(recoveryPer),
                                       isProgressBar: true)

        let deathRate = ResultModel(title: "Death Rate",
                                    result: String(deathPer) + " %",
                                    resultPercentage: deathPer,
                                    bgColor: getColorForThePercentage(1 - deathPer),
                                    isProgressBar: true)

        return [active,
                deaths,
                recovered,
                recoveryRate,
                deathRate]
    }

    private func percentageCalculator(_ cases: Double, _ countryData: CountryData) -> Double {
        cases / Double(countryData.cases)
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

struct CoronaStats_Previews: PreviewProvider {
    static var previews: some View {
        CoronaStats()
    }
}
