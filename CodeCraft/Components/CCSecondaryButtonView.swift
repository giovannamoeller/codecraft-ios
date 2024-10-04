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
    var isDisabled: Bool
    
    init(text: String,
         backgroundColor: Color = AppTheme.Colors.lightLavender,
         isAlternateStyle: Bool = false,
         isDisabled: Bool = false) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.isAlternateStyle = isAlternateStyle
        self.isDisabled = isDisabled
    }
    
    var body: some View {
        HStack {
            ResponsiveTextView(text: text,
                               style: .bodyBold,
                               alignment: .center,
                               foregroundStyle: isAlternateStyle ? .white : AppTheme.Colors.mediumLavender)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(isAlternateStyle ? AppTheme.Colors.mediumLavender : backgroundColor)
        .cornerRadius(28.0)
        .overlay {
            RoundedRectangle(cornerRadius: 28.0)
                .stroke(isAlternateStyle ? AppTheme.Colors.lightLavender : AppTheme.Colors.mediumLavender, lineWidth: 1.0)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}

#Preview {
    CCSecondaryButtonView(text: "Hello, World!")
}
