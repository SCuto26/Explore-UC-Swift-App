//
//  SchoolList.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI

struct SchoolList: View {
   @Environment(ModelData.self) private var modelData
   @State private var searchText = ""
   @State private var selectedCategory: String? = nil
   @State private var showingComparison = false
   @State private var showEmoji = false
   
   // Filter schools based on search text and category
   var filteredSchools: [UCSchool] {
       modelData.schools.filter { school in
           let matchesSearch = searchText.isEmpty ||
               school.name.localizedCaseInsensitiveContains(searchText) ||
               school.shortName.localizedCaseInsensitiveContains(searchText) ||
               school.city.localizedCaseInsensitiveContains(searchText)
           
           let matchesCategory = selectedCategory == nil ||
               school.category == selectedCategory
           
           return matchesSearch && matchesCategory
       }
   }
   
   // Get unique categories for the filter
   var categories: [String] {
       Array(Set(modelData.schools.map { $0.category })).sorted()
   }
   
   var body: some View {
       NavigationStack {
           ZStack {
               VStack {
                   // Category Filter
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 12) {
                           FilterChip(
                               title: "All",
                               isSelected: selectedCategory == nil,
                               action: {
                                   selectedCategory = nil
                                   showEmoji = false
                                   showEmoji = true
                               }
                           )
                           
                           ForEach(categories, id: \.self) { category in
                               FilterChip(
                                   title: category,
                                   isSelected: selectedCategory == category,
                                   action: {
                                       selectedCategory = category
                                       showEmoji = false
                                       showEmoji = true
                                   }
                               )
                           }
                       }
                       .padding(.horizontal)
                   }
                   .padding(.vertical, 8)
                   
                   List {
                       ForEach(filteredSchools) { school in
                           NavigationLink {
                               UCSchoolDetail(school: school)
                           } label: {
                               SchoolRow(school: school)
                           }
                       }
                   }
                   .listStyle(.plain)
               }
               
               CategoryAnimation(
                   category: selectedCategory,
                   isShowing: showEmoji
               )
           }
           .navigationTitle("UC Schools")
           .searchable(
               text: $searchText,
               prompt: "Search by name, abbreviation, or city"
           )
           .toolbar {
               if !modelData.comparisonModel.selectedSchools.isEmpty {
                   ToolbarItemGroup(placement: .topBarTrailing) {
                       Button(action: {
                           modelData.comparisonModel.selectedSchools.removeAll()
                       }) {
                           Text("Remove All")
                               .font(.caption)
                               .padding(.horizontal, 8)
                               .padding(.vertical, 4)
                               .background(
                                   Capsule()
                                       .fill(.red)
                               )
                               .foregroundStyle(.white)
                       }
                       
                       Button {
                           showingComparison = true
                       } label: {
                           Text("Comparisons")
                               .font(.caption)
                               .padding(.horizontal, 8)
                               .padding(.vertical, 4)
                               .background(
                                   Capsule()
                                       .fill(.blue)
                               )
                               .foregroundStyle(.white)
                       }
                   }
               }
           }
           .sheet(isPresented: $showingComparison) {
               ComparisonView()
           }
       }
   }
}

// Custom filter chip component
struct FilterChip: View {
   let title: String
   let isSelected: Bool
   let action: () -> Void
   
   var body: some View {
       Button(action: action) {
           Text(title)
               .font(.subheadline)
               .padding(.horizontal, 16)
               .padding(.vertical, 8)
               .background(
                   Capsule()
                       .fill(isSelected ? Color.blue : Color.gray.opacity(0.1))
               )
               .foregroundStyle(isSelected ? .white : .primary)
       }
   }
}

#Preview {
   SchoolList()
       .environment(ModelData())
}
