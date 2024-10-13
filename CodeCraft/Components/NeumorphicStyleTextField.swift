//
//  NeumorphicStyleTextField.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 13/10/24.
//

import SwiftUI

struct NeumorphicStyleTextField: View {
    var textField: TextField<Text>
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(AppTheme.Colors.lightShadow)
            textField
        }
        .padding()
        .foregroundColor(AppTheme.Colors.lightShadow)
        .background(AppTheme.Colors.indigo)
        .cornerRadius(6)
        .shadow(color: AppTheme.Colors.darkShadow, radius: 3, x: 2, y: 2)
        .shadow(color: AppTheme.Colors.lightShadow, radius: 3, x: -2, y: -2)
        
    }
}

#Preview {
    NeumorphicStyleTextField(textField: .init("Text", text: .constant("")), imageName: "magnifyingglass")
}
