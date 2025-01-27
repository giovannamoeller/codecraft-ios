//
//  SecondaryButtonView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct SecondaryButtonView: View {
    var text: String
    var backgroundColor: Color
    var isAlternateStyle: Bool
    var isDisabled: Bool
    var action: () -> Void
    
    init(text: String,
         backgroundColor: Color = AppTheme.Colors.lightLavender,
         isAlternateStyle: Bool = false,
         isDisabled: Bool = false,
         action: @escaping () -> Void = {}) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.isAlternateStyle = isAlternateStyle
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
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
    SecondaryButtonView(text: "Hello, World!", action: {
        print("Hello!")
    })
}
