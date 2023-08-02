//
//  Shops.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 31/07/2023.
//

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
    var loved: Bool
    var price: String
}

struct Coordinate: Codable {
    var latitude: Double
    var longtitude: Double
}
