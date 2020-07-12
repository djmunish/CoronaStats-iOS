//
//  MapView.swift
//  CoronaTracker
//
//  Created by Munish Sehdev on 2020-06-30.
//  Copyright © 2020 Munish Sehdev. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var countrySelected: CountryData?

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)
        let coordinate = CLLocationCoordinate2DMake(countrySelected?.countryInfo?.lat ?? 0.0, countrySelected?.countryInfo?.long ?? 0.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(countrySelected: nil)
    }
}
