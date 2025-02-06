//
//  DetailRow.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import SwiftUI

struct DetailRow: View {
    let title: String
    let value: String
    let iconName: String?
    
    init(title: String, value: String, iconName: String? = nil) {
        self.title = title
        self.value = value
        self.iconName = iconName
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let iconName = iconName {
                Image(systemName: iconName)
                    .foregroundStyle(.secondary)
                    .frame(width: 20)
            }
            
            Text(title)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack {
        DetailRow(title: "Founded", value: "1868", iconName: "calendar")
        DetailRow(title: "Location", value: "Berkeley", iconName: "mappin")
        DetailRow(title: "Enrollment", value: "45,000")
    }
    .padding()
}
