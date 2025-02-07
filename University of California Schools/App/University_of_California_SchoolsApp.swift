//
//  University_of_California_SchoolsApp.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI

@main
struct University_of_California_SchoolsApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
