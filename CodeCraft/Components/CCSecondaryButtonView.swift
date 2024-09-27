//
//  CCSecondaryButtonView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct CCSecondaryButtonView: View {
    var text: String
    var backgroundColor: Color
    var isAlternateStyle: Bool
    
    init(text: String,
         backgroundColor: Color = AppTheme.Colors.lightBrown,
         isAlternateStyle: Bool = false) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.isAlternateStyle = isAlternateStyle
    }
    
    var body: some View {
        HStack {
            Text(text)
                .appFont(AppTheme.Fonts.bodyBold)
                .foregroundStyle(isAlternateStyle ? .white : AppTheme.Colors.mediumBrown)
        }
        .frame(minWidth: 88)
        .padding()
        .background(isAlternateStyle ? AppTheme.Colors.mediumBrown : backgroundColor)
        .cornerRadius(28.0)
        .overlay {
            RoundedRectangle(cornerRadius: 28.0)
                .stroke(isAlternateStyle ? AppTheme.Colors.lightBrown : AppTheme.Colors.mediumBrown, lineWidth: 1.0)
        }
    }
}

#Preview {
    CCSecondaryButtonView(text: "Hello, World!")
}
