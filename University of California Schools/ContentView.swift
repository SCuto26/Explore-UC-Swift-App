//
//  ContentView.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
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
                    Label("Featured", systemImage: "star.fill")
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

// Basic SchoolList view for testing
struct SchoolList: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        NavigationStack {
            List(modelData.schools) { school in
                NavigationLink {
                    UCSchoolDetail(school: school)
                } label: {
                    SchoolRow(school: school)
                }
            }
            .navigationTitle("UC Schools")
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
