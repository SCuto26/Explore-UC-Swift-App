//
//  UCSchoolDetail.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI
import MapKit

struct UCSchoolDetail: View {
   @Environment(ModelData.self) private var modelData
   var school: UCSchool
   
   var body: some View {
       ScrollView {
           ZStack(alignment: .leading) {
               // Background campus image
               GeometryReader { geometry in
                   school.image
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: geometry.size.width, height: geometry.size.height)
                       .clipped()
               }
               .frame(height: 300)
               
               // School logo
               ZStack {
                   Circle()
                       .fill(.white)
                       .shadow(radius: 7)
                   
                   school.logo
                       .resizable()
                       .scaledToFit()
                       .padding(8)
                       .clipShape(Circle())
               }
               .frame(width: 100, height: 100)
               .overlay {
                   Circle()
                       .stroke(.white, lineWidth: 4)
               }
               .offset(y: 88)
               .padding(.leading, 10)
           }
           
           VStack(alignment: .leading, spacing: 16) {
               HStack {
                   Text(school.name)
                       .font(.title)
                       .fontWeight(.bold)
                   
                   Spacer()
                   
                   Button(action: {
                       modelData.comparisonModel.toggleSelection(for: school)
                   }) {
                       Text(
                           modelData.comparisonModel.isSelected(school) ? "Remove" :
                           modelData.comparisonModel.canAddMore ? "Compare" : "Max 3 Schools"
                       )
                       .font(.subheadline)
                       .padding(.horizontal, 12)
                       .padding(.vertical, 6)
                       .background(
                           Capsule()
                               .fill(
                                   modelData.comparisonModel.isSelected(school) ? .red :
                                   modelData.comparisonModel.canAddMore ? .blue : .gray
                               )
                       )
                       .foregroundStyle(.white)
                   }
                   .disabled(!modelData.comparisonModel.canAddMore && !modelData.comparisonModel.isSelected(school))
               }
               
               Divider()
               
               // Quick Facts Section
               GroupBox("Quick Facts") {
                   DetailRow(title: "Founded", value: "\(school.founded)")
                   DetailRow(title: "Location", value: school.city)
                   DetailRow(title: "Enrollment", value: "\(school.enrollment) students")
               }
               
               // Rankings Section
               GroupBox("Rankings") {
                   DetailRow(title: "National Universities", value: "#\(school.rankings.overall)")
                   DetailRow(title: "Public Schools", value: "#\(school.rankings.publicSchools)")
                   DetailRow(title: "Value", value: "#\(school.rankings.valueSchools)")
               }
               
               // Top Majors Section
               GroupBox("Top Majors") {
                   ForEach(school.topMajors, id: \.self) { major in
                       Text("• \(major)")
                           .padding(.vertical, 2)
                   }
               }
               
               // Tuition Section
               GroupBox("Annual Tuition") {
                   DetailRow(title: "In-State", value: "$\(school.tuition.inState)")
                   DetailRow(title: "Out-of-State", value: "$\(school.tuition.outOfState)")
               }
               
               // Map
               GroupBox("Location") {
                   Map(position: .constant(.region(MKCoordinateRegion(
                       center: school.locationCoordinate,
                       span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                   ))))
                   .frame(height: 200)
               }
           }
           .padding()
       }
       .navigationBarTitleDisplayMode(.inline)
       .toolbar {
           ToolbarItem(placement: .topBarTrailing) {
               PhotoCreditView(schoolName: school.shortName)
           }
       }
   }
}
