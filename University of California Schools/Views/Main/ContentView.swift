//
//  ContentView.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        TabView(selection: $selection) {
            FeaturedSchools()
                .tabItem {
                    Label("Featured", systemImage: "graduationcap.fill")
                }
                .tag(Tab.featured)
            
            SchoolList()
                .tabItem {
                    Label("All Schools", systemImage: "building.columns.fill")
                }
                .tag(Tab.list)
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
