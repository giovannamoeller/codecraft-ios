//
//  ArrayCodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct ArrayCodeCheatsheetView: View {
    var body: some View {
        ScrollView {
            Text("How to work with Arrays")
                .appFont(AppTheme.Fonts.title)
            
            CodeCheatsheetView(codeSnippets: Code.arrayCodeSnippet)
            
            NavigationLink {
                ArrayQuizView()
            } label: {
                HStack {
                    Text("Start Quiz")
                        .appFont(AppTheme.Fonts.bodyBold)
                    Image(systemName: "arrow.right")
                }
                .padding()
                .foregroundStyle(.white)
                .background(AppTheme.Colors.darkGreen)
                .cornerRadius(24.0)
                .frame(maxWidth: .infinity)
                .padding()
            }

        }
    }
}

#Preview {
    ArrayCodeCheatsheetView()
}
