//
//  SchoolRow.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI

struct SchoolRow: View {
    @Environment(ModelData.self) private var modelData
    var school: UCSchool
    
    var body: some View {
        HStack(spacing: 16) {
            // Logo container with white background
            ZStack {
                Circle()
                    .fill(.white)
                
                school.logo
                    .resizable()
                    .scaledToFit()
                    .padding(6)
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(school.name)
                    .font(.headline)
                
                HStack {
                    Text(school.city)
                    Text("•")
                    Text("#\(school.rankings.overall) in National Universities")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Comparison indicator
            if modelData.comparisonModel.isSelected(school) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
                    .imageScale(.large)
            }
        }
        .padding(.vertical, 8)
    }
}
