//
//  UCSchoolDetail.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import SwiftUI
import MapKit

struct UCSchoolDetail: View {
    @Environment(ModelData.self) var modelData
    var school: UCSchool
    
    var schoolIndex: Int {
        modelData.schools.firstIndex(where: { $0.id == school.id })!
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .leading) {
                // Background campus image
                school.image
                    .resizable()
                    .frame(height: 300)
                    .overlay {
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.4)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                
                // School logo
                school.logo
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .padding(.leading, 20)
                    .padding(.top, 200)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(school.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Rating system instead of favorite
                    SchoolRatingView(rating: .constant(4))
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
                    DetailRow(title: "Overall", value: "#\(school.rankings.overall)")
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
    }
}
