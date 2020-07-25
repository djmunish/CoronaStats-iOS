//
//  CountrySelectorWatch.swift
//  CoronaWatch Extension
//
//  Created by Ankur Sehdev on 25/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct CountrySelectorWatch: View {
    @Binding var countryCode: Country?
    @State private var countries = [Country]()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List() {
            ForEach(self.countries, id: \.self) { country in
                HStack(spacing: 10) {
                    Image(uiImage: country.flagImage)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 1))
                        .shadow(radius: 10)
                        .frame(width: 40, height: 40)
                    Text(country.name)
                }
                .padding()
                .onTapGesture {
                    self.countryCode = country
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }.onAppear {
            self.populateCountriesArray(arr: self.countries)
        }
    }
    
    func populateCountriesArray(arr: [Country]?) {
        countries = [Country]()
        for code in NSLocale.isoCountryCodes  {
            
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            
            if let flagImage = UIImage(named: name.lowercased().replacingOccurrences(of: " ", with: "-")) {
                countries.append(Country(name: name, code: code, flagImage: flagImage))
            }
        }
        countries = countries.sorted { $0.name < $1.name }
        countries.insert(Country(name: "Worldwide",
                                 code: nil,
                                 flagImage: UIImage(named: "EarthImage")!),
                         at: 0)
    }
}

