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
        TabView {
            StatsView()
                .tabItem{
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("Stats")
            }
            MapView(coordinate: CLLocationCoordinate2D(latitude: 20, longitude: 30))
                .tabItem{
                    Image(systemName: "map")
                    Text("Map")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
