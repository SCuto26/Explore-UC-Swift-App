//
//  ComparisonModel.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/27/25
//

import SwiftUI

@Observable
class ComparisonModel {
    var selectedSchools: [UCSchool] = []
    let maxSchools = 3
    
    func toggleSelection(for school: UCSchool) {
        if isSelected(school) {
            selectedSchools.removeAll { $0.id == school.id }
        } else if selectedSchools.count < maxSchools {
            selectedSchools.append(school)
        }
    }
    
    func isSelected(_ school: UCSchool) -> Bool {
        selectedSchools.contains { $0.id == school.id }
    }
    
    var canAddMore: Bool {
        selectedSchools.count < maxSchools
    }
}
