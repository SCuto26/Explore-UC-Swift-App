//
//  ComparisonView.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/27/25.
//

import SwiftUI

struct ComparisonView: View {
    @Environment(ModelData.self) private var modelData
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            if modelData.comparisonModel.selectedSchools.isEmpty {
                ContentUnavailableView(
                    "No Schools Selected",
                    systemImage: "building.2",
                    description: Text("Add schools to compare by tapping 'Compare' on a school's detail page")
                )
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        // Schools count indicator
                        HStack {
                            Text("Comparing \(modelData.comparisonModel.selectedSchools.count) of 3 schools")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Schools Grid
                        Grid(alignment: .leading) {
                            // Headers
                            GridRow {
                                Text("School")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                ForEach(modelData.comparisonModel.selectedSchools) { school in
                                    VStack {
                                        school.logo
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        Text(school.shortName)
                                            .font(.caption)
                                            .bold()
                                        
                                        Button(action: {
                                            modelData.comparisonModel.toggleSelection(for: school)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                            
                            // Rankings
                            makeGridRow(
                                title: "Ranking",
                                values: modelData.comparisonModel.selectedSchools.map { "#\($0.rankings.overall)" }
                            )
                            
                            // Enrollment
                            makeGridRow(
                                title: "Enrollment",
                                values: modelData.comparisonModel.selectedSchools.map { "\($0.enrollment)" }
                            )
                            
                            // In-State Tuition
                            makeGridRow(
                                title: "In-State",
                                values: modelData.comparisonModel.selectedSchools.map { "$\($0.tuition.inState)" }
                            )
                            
                            // Out-of-State Tuition
                            makeGridRow(
                                title: "Out-of-State",
                                values: modelData.comparisonModel.selectedSchools.map { "$\($0.tuition.outOfState)" }
                            )
                            
                            // Campus Setting
                            makeGridRow(
                                title: "Campus Setting",
                                values: modelData.comparisonModel.selectedSchools.map { $0.category }
                            )
                        }
                        .padding()
                    }
                }
                .navigationTitle("Compare Schools")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func makeGridRow(title: String, values: [String]) -> some View {
        GridRow {
            Text(title)
                .foregroundStyle(.secondary)
            ForEach(values, id: \.self) { value in
                Text(value)
            }
        }
    }
}
