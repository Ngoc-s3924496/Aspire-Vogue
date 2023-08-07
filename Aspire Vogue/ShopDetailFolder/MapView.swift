/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Duong Vu Thanh Ngoc
 ID: s3924496
 Created  date: 31/07/2023
 Last modified: 07/08/2023
 Acknowledgement: SwiftUI
 */

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
