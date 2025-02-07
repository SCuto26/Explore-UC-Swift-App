//
//  MapView.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var title: String
    
    @State private var position: MapCameraPosition
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        self._position = State(
            initialValue: .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01
                    )
                )
            )
        )
    }
    
    var body: some View {
        Map(position: $position) {
            Marker(title, coordinate: coordinate)
        }
        .mapStyle(.standard)
        .mapControls {
            MapCompass()
            MapScaleView()
        }
    }
}

#Preview {
    let modelData = ModelData()
    return MapView(
        coordinate: modelData.schools[0].locationCoordinate,
        title: modelData.schools[0].name
    )
    .frame(height: 300)
}
