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

        guard let ann = addAnnotation() else { return }
        uiView.addAnnotation(ann)
    }

    private func addAnnotation() -> PhotoAnnotation? {

        guard let countryData = countrySelected?.countryInfo, let countryName = countrySelected?.country else {
            return nil
        }

        let annotation = PhotoAnnotation()
        annotation.title = countrySelected?.country
//        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: countryData.lat, longitude: countryData.long)

        let imageName = countryName.lowercased().replacingOccurrences(of: " ", with: "-") + "(pin)"
        annotation.image = UIImage(named: imageName)
        if let annotationImage = annotation.image {
            annotation.image = annotationImage.resizeImage(targetSize: CGSize(width: 45, height: 45))
        }
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(countrySelected: nil)
    }
}


class Coordinate: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Placemark"

        // attempt to find a cell we can recycle
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            // we didn't find one; make a new one
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

            // allow this to show pop up information
            annotationView?.canShowCallout = true

            // attach an information button to the view
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            // we have a view to reuse, so give it the new annotation
            annotationView?.annotation = annotation
        }

        // whether it's a new view or a recycled one, send it back
        return annotationView
    }
}


extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
