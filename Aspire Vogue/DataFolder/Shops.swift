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

import Foundation
import CoreLocation

struct Shop: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var facebook: String
    var instagram: String
    var image: [String]
    var address: String
    var coordinate: Coordinate
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longtitude)}
    var category: [String]
    var loved: Bool
    var price: String
}

struct Coordinate: Codable {
    var latitude: Double
    var longtitude: Double
}
