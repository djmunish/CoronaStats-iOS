//
//  CountrySelector.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-07-01.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct CountrySelector: View {
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var countries: [Country]!
    @State private var chunkedCountries = [[Country]]()
    @State var selectedCountry: Country?
    @Environment(\.presentationMode) var presentationMode
    @Binding var countryCode: Country?

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search Country")
                    .searchCallback {
                        self.searchCountry()
                    }
                 List(selection: $selectedCountry) {
                    ForEach(self.chunkedCountries, id: \.self) { item in
                        HStack {
                            ForEach(item, id: \.self) { country in
                                VStack {
                                    Image(uiImage: country.flagImage)
                                        .resizable()
                                        .scaledToFit()
                                    Text(country.name)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(3)
                                }
                                .frame(width: (UIScreen.screenWidth - 50) / 3, height: (UIScreen.screenWidth - 50) / 3)
                                .onTapGesture {
                                    self.countryCode = country
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
                .resignKeyboardOnDragGesture()
                .onAppear {
                   UITableView.appearance().separatorStyle = .none
                   // can update any other property like tableFooterView etc
                }.onDisappear {
                   //revert appearance so that it does not break other UI
                   UITableView.appearance().separatorStyle = .singleLine
                }
            }
            .navigationBarTitle("Search")
        }.onAppear {
            self.populateCountriesArray(arr: self.countries)
        }
    }
    
    func populateCountriesArray(arr: [Country]?) {
        if let input = arr {
            chunkedCountries = input.chunked(into: 3)
        } else {
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
            chunkedCountries = countries.chunked(into: 3)
        }
    }

    private func searchCountry() {
        print(searchText)
        let filteredCountries = countries.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }

        if filteredCountries.count > 0 {
            populateCountriesArray(arr: filteredCountries)
        } else if (searchText.count == 0) {
            populateCountriesArray(arr: countries)
        }
    }
}
