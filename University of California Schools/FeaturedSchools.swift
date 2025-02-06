//
//  FeaturedSchools.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import SwiftUI

struct FeaturedSchools: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Featured Schools Header with Animation
                PageHeader()
                    .padding(.bottom)
                
                // Featured Schools Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(modelData.features) { school in
                        NavigationLink {
                            UCSchoolDetail(school: school)
                        } label: {
                            FeaturedCard(school: school)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Featured Schools")
        }
    }
}

// Custom header view with animation
struct PageHeader: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Discover")
                .font(.title2)
                .foregroundStyle(.secondary)
            Text("Top UC Schools")
                .font(.title)
                .fontWeight(.bold)
        }
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }
        }
    }
}

// Featured school card view
struct FeaturedCard: View {
    let school: UCSchool
    
    var body: some View {
        VStack(alignment: .leading) {
            school.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray.opacity(0.2), lineWidth: 1)
                )
            
            HStack(alignment: .top) {
                school.logo
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(school.shortName)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text("#\(school.rankings.overall) in Rankings")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(.bottom)
    }
}
