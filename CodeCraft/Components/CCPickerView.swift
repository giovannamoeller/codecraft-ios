//
//  CCPickerView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

struct CCPickerView: View {
    @Binding var selectedSegment: Int
    var segments: [CodeLanguage] = CodeLanguage.allCases
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 24.0)
                    .fill(Color(AppTheme.Colors.lightBrown))
                
                // Sliding selector
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: max(0, (geometry.size.width / CGFloat(segments.count)) - 8), height: max(0, geometry.size.height - 8))
                    .offset(x: CGFloat(selectedSegment) * (geometry.size.width / CGFloat(segments.count)) + 4)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedSegment)
                
                // Segment buttons
                HStack(spacing: 0) {
                    ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in
                        Button(action: {
                            selectedSegment = index
                        }) {
                            Text(segment.rawValue)
                                .font(AppTheme.Fonts.bodyRegular)
                                .frame(width: geometry.size.width / CGFloat(segments.count), height: geometry.size.height)
                                .foregroundStyle(selectedSegment == index ? .black : .brown)
                        }
                    }
                }
            }
        }
        .frame(height: 48)
        .cornerRadius(24)
    }
}

#Preview {
    CCPickerView(selectedSegment: .constant(0))
}
