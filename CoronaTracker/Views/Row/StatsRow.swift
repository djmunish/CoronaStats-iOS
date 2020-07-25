//
//  StatsRow.swift
//  CoronaTracker
//
//  Created by Ankur Sehdev on 25/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct StatsRow: View {
    @State var statItem: ResultModel
    
    var body: some View {
        VStack {
            Text(statItem.title)
            .bold()
            .multilineTextAlignment(.center)
        Spacer()
        Text(statItem.result)
            .foregroundColor(Color("resultColor"))
            .bold()
            .padding(.bottom, 10)
            .padding(.horizontal, 15)
            .padding(.top, 10)
            .background(statItem.bgColor)
            .cornerRadius(20.0)
        }
        .frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
        ).padding()
    }
}
