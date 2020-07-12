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
                ForEach(0..<4) { index in
                    Text("Active Cases \n \(self.countryResult?.cases ?? 0)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 90)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20.0)
                }

            }
//                Text("Active Cases \n \(countryResult?.cases ?? 0)")
//                    .bold()
//                    .multilineTextAlignment(.center)
//                    .lineLimit(2)
//                    .padding(.horizontal, 90)
//                    .padding(.bottom, 10)
//                    .padding(.top, 10)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(20.0)
//                Spacer().frame(height: 5)
//                Text("Deaths \n \(countryResult?.deaths ?? 0)")
//                    .bold()
//                    .multilineTextAlignment(.center)
//                    .lineLimit(2)
//                    .padding(.horizontal, 100)
//                    .padding(.bottom, 10)
//                    .padding(.top, 10)
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(20.0)
//                Spacer().frame(height: 5)
//                Text("Recoveries \n \(countryResult?.recovered ?? 0)")
//                    .bold()
//                    .multilineTextAlignment(.center)
//                    .lineLimit(2)
//                    .padding(.horizontal, 100)
//                    .padding(.bottom, 10)
//                    .padding(.top, 10)
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(20.0)
//                Spacer().frame(height: 5)
//            }
            HStack{
                Group {
                HStack {
                    Text("Last Updated:")
                        .bold()
                        .foregroundColor(.secondary)
                    Button(action: {
                        print("Refresh!!")
                        self.downloadData(countryCode: self.countryCode?.code)
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            Spacer()
                .frame(height: 10)
            Group {
                Button(action: {
                    self.showingDetail.toggle()
                }) {
                    Image(systemName: "globe")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .frame(width: 44, height: 44)
                }
                .sheet(isPresented: $showingDetail, onDismiss: {
                    self.downloadData(countryCode: self.countryCode?.code)
                }){
                    CountrySelector(countryCode: self.$countryCode)
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
                    self.calculate(stats: stats)
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
