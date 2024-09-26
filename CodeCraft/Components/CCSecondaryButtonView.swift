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
    
    init(text: String, backgroundColor: Color = Color(AppTheme.Colors.lightBrown)) {
        self.text = text
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack {
            Text(text)
                .appFont(AppTheme.Fonts.bodyBold)
                .foregroundStyle(AppTheme.Colors.mediumBrown)
        }
        .frame(minWidth: 88)
        .padding()
        .background(backgroundColor)
        .cornerRadius(28.0)
        .overlay {
            RoundedRectangle(cornerRadius: 28.0)
                .stroke(Color(AppTheme.Colors.mediumBrown), lineWidth: 1.0)
        }
    }
}

#Preview {
    CCSecondaryButtonView(text: "Hello, World!")
}
