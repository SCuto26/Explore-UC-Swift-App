//
//  SchoolRatingView.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 2/6/25.
//

import SwiftUI

struct SchoolRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundStyle(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            rating = index
                        }
                    }
            }
        }
    }
}
