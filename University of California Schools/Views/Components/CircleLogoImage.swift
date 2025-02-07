//
//  CircleLogoImage.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/22/25.
//

import SwiftUI

struct CircleLogoImage: View {
    var image: Image
    var shadowRadius: CGFloat = 7
    var strokeWidth: CGFloat = 4
    var size: CGFloat = 100
    
    var body: some View {
        image
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: strokeWidth)
            }
            .shadow(radius: shadowRadius)
            .accessibilityLabel("School logo")
    }
}

// Preview provider for development and testing
#Preview {
    let modelData = ModelData()
    return CircleLogoImage(image: modelData.schools[0].logo)
        .background(Color.gray.opacity(0.3))
        .padding()
}
