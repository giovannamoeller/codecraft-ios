//
//  CCPrimaryButtonView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct CCPrimaryButtonView: View {
    var text: String
    var displayIcon: Bool
    var isAlternateStyle: Bool
    
    init(text: String,
         displayIcon: Bool = true,
         isAlternateStyle: Bool = false) {
        self.text = text
        self.displayIcon = displayIcon
        self.isAlternateStyle = isAlternateStyle
    }
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(text))
                .appFont(AppTheme.Fonts.bodyBold)
            if displayIcon {
                Image(systemName: "arrow.right")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isAlternateStyle ? .white : AppTheme.Colors.indigo)
        .foregroundStyle(isAlternateStyle ? AppTheme.Colors.indigo : .white)
        .cornerRadius(28.0)
    }
}

#Preview {
    CCPrimaryButtonView(text: "Hello, World!")
}
