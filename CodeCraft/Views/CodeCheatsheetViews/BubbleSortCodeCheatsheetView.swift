//
//  BubbleSortCodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import SwiftUI

struct BubbleSortCodeCheatsheetView: View {
    var body: some View {
        ZStack {
            AppTheme.Colors.indigo.ignoresSafeArea()
            
            ScrollView {
                CodeCheatsheetView(text: "How to implement bubble sort", codeSnippets: Code.bubbleSortCode)
                
                NavigationLink {
                    //ArrayQuizView()
                } label: {
                    PrimaryButtonView(text: "Next algorithm", isAlternateStyle: true)
                        .frame(maxWidth: 240)
                        .padding(.top, 32)
                }
            }
        }
    }
}

#Preview {
    BubbleSortCodeCheatsheetView()
}
