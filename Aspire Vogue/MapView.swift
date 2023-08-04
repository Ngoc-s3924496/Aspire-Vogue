//
//  MapView.swift
//  Contact List
//
//  Created by Duong Vu Thanh Ngoc on 28/07/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    let shop: Shop
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [shop]){ shop in
            // Marker for exact location
            MapMarker(coordinate: shop.locationCoordinate)
        }
        .onAppear {
            // Set the region of the map
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
        }
    }
}
