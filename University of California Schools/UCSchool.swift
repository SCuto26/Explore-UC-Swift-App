//
//  UCSchool.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

struct UCSchool: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var shortName: String
    var city: String
    var founded: Int
    var topMajors: [String]
    var isFavorite: Bool
    var isFeatured: Bool
    var enrollment: Int
    var tuition: Tuition
    var rankings: Rankings
    var category: String
    var imageName: String
    var logoName: String
    var coordinates: Coordinates
    
    // Nested structs for organized data
    struct Tuition: Hashable, Codable {
        var inState: Int
        var outOfState: Int
    }
    
    struct Rankings: Hashable, Codable {
        var overall: Int
        var publicSchools: Int
        var valueSchools: Int
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    // Computed property to convert coordinates for MapKit
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    // Computed properties for loading images
    var image: Image {
        Image(imageName)
    }
    
    var logo: Image {
        Image(logoName)
    }
    
    // User-specific data (in-memory changes)
    private var _userRating: Int = 0
    var userRating: Int {
        get { _userRating }
        set { _userRating = min(max(newValue, 0), 5) } // Ensures rating is between 0 and 5
    }
    
    private var _userNotes: String = ""
    var userNotes: String {
        get { _userNotes }
        set { _userNotes = newValue }
    }
    
    // These properties won't be encoded/decoded since they're for temporary storage
    enum CodingKeys: String, CodingKey {
        case id, name, shortName, city, founded, topMajors, isFavorite, isFeatured
        case enrollment, tuition, rankings, category, imageName, logoName, coordinates
        // Note: userRating and userNotes are deliberately omitted from coding keys
    }
}
