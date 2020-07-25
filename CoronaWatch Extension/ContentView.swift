//
//  ContentView.swift
//  CoronaWatch Extension
//
//  Created by Ankur Sehdev on 22/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var countryResult: CountryData?
    @State private var listData: [ResultModel] = [ResultModel]()
    @State private var listDataRecovery: [ResultModel] = [ResultModel]()
    @State private var listDataDeath: [ResultModel] = [ResultModel]()
    @State var countryCode: Country?
    @State private var currentPage = 0

    var body: some View {
        
        //Pager Manager
        VStack {
            PagerManager(pageCount: 3, currentIndex: $currentPage) {
                List() {
                    ForEach(listData, id: \.self) { item in
                        if (item.isWatch) {
                            NavigationLink(destination:                         CountrySelectorWatch(countryCode: self.$countryCode)){
                            CountryRow(country: item.country!)
                                .frame(height: 120)
                            }
                        } else {
                            StatsRow(statItem: item)
                        }
                    }
                }
                List() {
                    ForEach(listDataRecovery, id: \.self) { item in
                        ProgressWatch(statItem: item)
                    }
                }
                List() {
                    ForEach(listDataDeath, id: \.self) { item in
                        ProgressWatch(statItem: item)
                    }
                }
            }
            
            Spacer()
            //Page Control
            HStack{
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage == 0 ? Color.white:Color.gray)
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage == 1 ? Color.white:Color.gray)
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(currentPage == 2 ? Color.white:Color.gray)
            }
        }.onAppear {
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
                        self.listData = data[0]
                        self.listDataRecovery = data[1]
                        self.listDataDeath = data[2]
                    }
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    private func displayString(countryData: CountryData?) -> [[ResultModel]]? {
        guard let data = countryData else {
            return nil
        }

        let recoveryPer = percentageCalculator(Double(data.recovered), data)
        let deathPer = percentageCalculator(Double(data.deaths), data)

        let world = Country(name: countryCode?.name ?? "Worldwide",
                            flagImage: countryCode?.flagImage ?? UIImage(named: "EarthImage")!)
        let country = ResultModel(title: "", result: "", bgColor: .red, isWatch: true, country: world)
        
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
                                       isProgressBar: true)

        let deathRate = ResultModel(title: "Death Rate",
                                    result: String(deathPer) + " %",
                                    resultPercentage: deathPer,
                                    bgColor: getColorForThePercentage(1 - deathPer),
                                    isProgressBar: true)

        return [[country,
                active,
                deaths,
                recovered],
                [recoveryRate],
                [deathRate]]
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
