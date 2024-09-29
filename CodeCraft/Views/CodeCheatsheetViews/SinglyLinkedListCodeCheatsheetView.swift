//
//  SinglyLinkedListCodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct SinglyLinkedListCodeCheatsheetView: View {
    var body: some View {
        ScrollView {
            Text("How to work with singly linked lists")
                .appFont(AppTheme.Fonts.title)
            
            CodeCheatsheetView(codeSnippets: Code.singlyLinkedListCodeSnippet)
            
            NavigationLink {
                ArrayQuizView()
            } label: {
                CCPrimaryButtonView(text: "Start Quiz")
                    .padding(.top, 32)
            }

        }
    }
}

#Preview {
    SinglyLinkedListCodeCheatsheetView()
}
