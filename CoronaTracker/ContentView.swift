//
//  ContentView.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-06-30.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {

    var body: some View {
        NavigationView {
            StatsView()
            .navigationBarTitle(Text("Stats"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
