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
            MapMarker(coordinate: shop.locationCoordinate)
        }
        .onAppear {
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
        }
    }
}
