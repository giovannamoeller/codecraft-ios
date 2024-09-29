//
//  CCPickerView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

struct CCPickerView<T: RawRepresentable>: View where T.RawValue == String {
    @Binding var selectedSegment: Int
    var array: [T]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 24.0)
                    .fill(AppTheme.Colors.lightLavender)
                
                // Sliding selector
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: max(0, (geometry.size.width / CGFloat(array.count)) - 8), height: max(0, geometry.size.height - 8))
                    .offset(x: CGFloat(selectedSegment) * (geometry.size.width / CGFloat(array.count)) + 4)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedSegment)
                
                // Segment buttons
                HStack(spacing: 0) {
                    ForEach(Array(array.enumerated()), id: \.offset) { index, segment in
                        Button(action: {
                            selectedSegment = index
                        }) {
                            Text(segment.rawValue)
                                .font(AppTheme.Fonts.bodyRegular)
                                .frame(width: geometry.size.width / CGFloat(array.count), height: geometry.size.height)
                                .foregroundStyle(selectedSegment == index ? AppTheme.Colors.indigo : AppTheme.Colors.mediumLavender)
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
    CCPickerView(selectedSegment: .constant(0), array: CodeLanguage.allCases)
}
