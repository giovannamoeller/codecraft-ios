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
    
    init(text: String, displayIcon: Bool = true) {
        self.text = text
        self.displayIcon = displayIcon
    }
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(text))
                .appFont(AppTheme.Fonts.bodyBold)
            if displayIcon {
                Image(systemName: "arrow.right")
            }
        }
        .frame(minWidth: 148)
        .padding()
        .background(AppTheme.Colors.indigo)
        .foregroundStyle(.white)
        .cornerRadius(28.0)
    }
}

#Preview {
    CCPrimaryButtonView(text: "Hello, World!")
}
