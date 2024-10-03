//
//  SinglyLinkedListCodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct SinglyLinkedListCodeCheatsheetView: View {
    var body: some View {
        ZStack {
            AppTheme.Colors.indigo.ignoresSafeArea()
            
            ScrollView {
                CodeCheatsheetView(text: "How to work with singly linked lists", codeSnippets: Code.bubbleSortCode)
                
                NavigationLink {
                    //ArrayQuizView()
                } label: {
                    CCPrimaryButtonView(text: "Start quiz", isAlternateStyle: true)
                        .frame(maxWidth: 240)
                        .padding(.top, 32)
                }
            }
        }
    }
}

#Preview {
    SinglyLinkedListCodeCheatsheetView()
}
