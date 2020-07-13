//
//  StatsView.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-06-30.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    @State var showingDetail = false
    @State var countryCode: Country?
    @State var percentageRecovered = 0.0
    @State var countryResult: CountryData?
    @State private var listData: [ResultModel] = [ResultModel]()
    @State var progressValue: Float = 0.5

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            MapView(countrySelected: countryResult)
            Group {
                Image(uiImage: ((countryCode?.flagImage) ?? UIImage(named: "EarthImage"))!)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .frame(width: 100, height: 100)
                    .offset(y: -70)
                    .padding(.bottom, -130)
                    .foregroundColor(.blue)
                Spacer().frame(height: -20)
                Text(countryCode?.name ?? "Worldwide")
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, 25)
                    .foregroundColor(.black)
                    .cornerRadius(5.0)
                Spacer().frame(height: 5)
            }
            List() {
                ForEach(listData, id: \.self) { item in
                    HStack{
                        Text(item.title)
                        .bold()
                        .foregroundColor(.black)
                        Spacer()


                        if item.isProgressBar {
                            ProgressBar(countryResult: item)
                            .frame(width: 150.0, height: 150.0)
                            .padding(40.0)
                        } else {
                            Text(item.result)
                            .bold()
                            .padding(.bottom, 10)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                            .background(item.bgColor)
                            .foregroundColor(.white)
                            .cornerRadius(20.0)
                        }

                    }
                .padding()
                }

            }
            HStack {
                Group {
                    Button(action: {
                        self.showingDetail.toggle()
                    }) {
                        Image(systemName: "globe")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                            .padding(.vertical, 20).padding(.horizontal, 20)
                    }
                    .sheet(isPresented: $showingDetail, onDismiss: {
                        self.downloadData(countryCode: self.countryCode?.code)
                    }){
                        CountrySelector(countryCode: self.$countryCode)
                    }
                }
                Spacer()
                Group {
                    HStack {
                        Button(action: {
                            self.downloadData(countryCode: self.countryCode?.code)
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            .padding(.vertical, 20).padding(.horizontal, 20)

                        }

                    }
                }
        }
        .padding()
        }
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
                    if let data = self.displayString(countryData: stats){
                        self.listData = data
                    }
                }
            case .failure(let error):
                print(error.rawValue)
//                self.showErrorAlert(title: "Unable to retrieve data", message: error.rawValue)
                DispatchQueue.main.async {
                    //                    self.finishedDownloading = true
                    //                    self.refreshButton.layer.removeAllAnimations()
                    //                    self.confirmedCasesNumberLabel.text = "0"
                    //                    self.confirmedDeathsNumberLabel.text = "0"
                    //                    self.confirmedRecoveriesNumberLabel.text = "0"
                }
            }
        }
    }

    private func calculate(stats: CountryData) {
        percentageRecovered = Double(stats.recovered * 100 / stats.cases)
        print(percentageRecovered)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
