//
//  MapView.swift
//  FoodPin
//
//  Created by donghs on 8/17/26.
//

import SwiftUI
import MapKit

struct MapView: View {

    let location: String

    @State private var markerLocation = CLLocation()
    @State private var position: MapCameraPosition = .automatic


    var body: some View {
        Map(position: $position) {
            Marker("Here", coordinate: markerLocation.coordinate)
                .tint(.red)
        }
            .task {
                convertAddress(location: location)
            }
    }

    private func convertAddress(location: String) {

        // Get location
        let geoCoder = CLGeocoder()

        geoCoder.geocodeAddressString(
            location,
            completionHandler: { placemarks, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                guard let placemarks = placemarks,
                    let location = placemarks[0].location
                else {
                    return
                }

                let region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))

                self.position = .region(region)
                self.markerLocation = location
            })
    }
}

#Preview {
    MapView(location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong")
}
