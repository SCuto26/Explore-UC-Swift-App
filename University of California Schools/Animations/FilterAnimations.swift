//
//  FilterAnimations.swift
//  University of California Schools
//
//  Created by Stefan Cutovic on 1/27/25.
//

import SwiftUI

struct FloatingEmoji: View {
    let emoji: String
    let index: Int
    @State private var offset: CGSize = .zero
    @State private var opacity: Double = 0
    
    var body: some View {
        Text(emoji)
            .font(.system(size: 120))
            .offset(offset)
            .opacity(opacity)
            .onAppear {
                let screenHeight = UIScreen.main.bounds.height
                let verticalSpacing = screenHeight / 4
                let initialY = (verticalSpacing * CGFloat(index)) - (screenHeight / 3.5)
                
                offset = CGSize(
                    width: -UIScreen.main.bounds.width,
                    height: initialY
                )
                
                withAnimation(
                    .easeOut(duration: 1.5)
                    .delay(Double(index) * 0.3)
                ) {
                    offset = CGSize(
                        width: UIScreen.main.bounds.width,
                        height: initialY + CGFloat.random(in: -50...50)
                    )
                    opacity = 1
                }
                
                withAnimation(
                    .easeIn(duration: 0.3)
                    .delay(Double(index) * 0.3 + 1.2)
                ) {
                    opacity = 0
                }
            }
    }
}

struct CategoryAnimation: View {
    let category: String?
    let isShowing: Bool
    
    private func emojisForCategory(_ category: String?) -> [String] {
        switch category {
        case "Coastal": return ["🌊", "⛱️", "🏖️"]
        case "Rural": return ["🌾", "🌲", "🍃"]
        case "Suburban": return ["🏘️", "🏡", "🌳"]
        case "Urban": return ["🌆", "🏙️", "🌇"]
        default: return []  // Return empty array for "All"
        }
    }
    
    var body: some View {
        if isShowing && category != nil {  // Only show if category is not nil (not "All")
            ZStack {
                ForEach(Array(emojisForCategory(category).enumerated()), id: \.element) { index, emoji in
                    FloatingEmoji(emoji: emoji, index: index)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
