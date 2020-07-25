//
//  CountryRow.swift
//  CoronaTracker
//
//  Created by Ankur Sehdev on 25/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct CountryRow: View {
    @State var country: Country
    var body: some View {
        VStack {
            Spacer().frame(height: 15)
            Image(uiImage: country.flagImage)
                .resizable()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)
                .frame(width: 80, height: 80)
            Spacer()
            Text(country.name)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .cornerRadius(5.0)
            Spacer().frame(height: 15)
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
        )
        .padding(20)
    }
}
