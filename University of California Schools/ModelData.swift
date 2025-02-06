//
//  ModelData.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import SwiftUI
import Foundation
import CoreLocation

@Observable
final class ModelData: ObservableObject {
    var schools: [UCSchool] = load("ucschools.json")
    
    var features: [UCSchool] {
        schools.filter { $0.isFeatured }
    }
    
    var categories: [String: [UCSchool]] {
        Dictionary(
            grouping: schools,
            by: { $0.category }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
