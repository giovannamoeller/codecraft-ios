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
        HStack(spacing: 8) {
            ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in
                Button(action: {
                    withAnimation {
                        selectedSegment = index
                    }
                }) {
                    Text(segment.rawValue)
                        .appFont(AppTheme.Fonts.bodyRegular)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            selectedSegment == index ?
                            Color.white :
                                Color.clear
                        )
                        .foregroundStyle(selectedSegment == index ? .black : Color(AppTheme.Colors.mediumBrown))
                        .cornerRadius(20)
                }
            }
        }
        .padding(4)
        .background(Color(AppTheme.Colors.lightBrown))
        .cornerRadius(24)
    }
}

#Preview {
    CCPickerView(selectedSegment: .constant(0))
}
