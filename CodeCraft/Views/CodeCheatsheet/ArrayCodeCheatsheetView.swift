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
                CCPrimaryButtonView(text: "Start Quiz")
            }

        }
    }
}

#Preview {
    ArrayCodeCheatsheetView()
}
