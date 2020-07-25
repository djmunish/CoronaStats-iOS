//
//  ProgressWatch.swift
//  CoronaTracker
//
//  Created by Ankur Sehdev on 25/07/20.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI

struct ProgressWatch: View {
    @State var statItem: ResultModel

    var body: some View {
        VStack(alignment: .center) {
            Text(statItem.title)
                .bold()
            Spacer(minLength: 15)
            ProgressBar(countryResult: statItem)
                .frame(width: 140, height: 120)
            Spacer(minLength: 15)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
        .padding(10)
    }
}
