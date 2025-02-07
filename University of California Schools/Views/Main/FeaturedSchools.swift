//
//  FeaturedSchools.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI

struct FeaturedSchools: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) { // Increased spacing between sections
                    // Header with Animation
                    PageHeader()
                        .padding(.top, 20)
                    
                    // Featured Schools List
                    VStack(spacing: 24) { // Increased spacing between schools
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
            }
            .navigationTitle("Featured")
        }
    }
}

struct FeaturedCard: View {
    let school: UCSchool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            school.image
                .resizable()
                .aspectRatio(16/9, contentMode: .fill) // Fixed aspect ratio
                .frame(height: 200) // Taller height for better visibility
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            HStack(spacing: 12) {
                school.logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(school.shortName)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text("#\(school.rankings.overall) in National Rankings")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(.bottom, 8)
    }
}

struct PageHeader: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 12) {
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
