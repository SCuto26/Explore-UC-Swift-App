//
//  SchoolRow.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import SwiftUI

struct SchoolRow: View {
    var school: UCSchool
    
    var body: some View {
        HStack(spacing: 16) {
            school.logo
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(school.name)
                    .font(.headline)
                
                HStack {
                    Text(school.city)
                        .foregroundStyle(.secondary)
                    
                    Text("•")
                        .foregroundStyle(.secondary)
                    
                    Text("#\(school.rankings.overall)")
                        .foregroundStyle(.secondary)
                }
                .font(.subheadline)
            }
            
            Spacer()
            
            if school.isFeatured {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let modelData = ModelData()
    return Group {
        SchoolRow(school: modelData.schools[0])
        SchoolRow(school: modelData.schools[1])
    }
    .padding()
}
