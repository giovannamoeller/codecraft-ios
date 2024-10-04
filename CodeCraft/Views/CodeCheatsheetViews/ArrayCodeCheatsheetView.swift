//
//  ArrayCodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct ArrayCodeCheatsheetView: View {
    var body: some View {
        ZStack {
            AppTheme.Colors.indigo.ignoresSafeArea()
            
            ScrollView {
                CodeCheatsheetView(text: "How to work with arrays", codeSnippets: Code.arrayCodeSnippet)
                
                NavigationLink {
                    ArrayQuizView()
                } label: {
                    PrimaryButtonView(text: "Start quiz", isAlternateStyle: true)
                        .frame(maxWidth: 240)
                        .padding(.top, 32)
                }
            }
        }
    }
}

#Preview {
    ArrayCodeCheatsheetView()
}
