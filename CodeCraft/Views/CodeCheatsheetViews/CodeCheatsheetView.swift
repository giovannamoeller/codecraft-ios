//
//  CodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

struct CodeCheatsheetView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var text: String
    let codeSnippets: [CodeLanguage: String]
    private var codeSyntaxHighlight: CodeSyntaxHighlight = CodeSyntaxHighlight()
    private var code: String {
        codeSnippets[programmingLanguages[selectedSegment]] ?? ""
    }
    
    @State private var programmingLanguages: [CodeLanguage] = CodeLanguage.allCases
    @State private var selectedLanguage: CodeLanguage = .python
    @State private var selectedSegment: Int = 0
    
    init(text: String, codeSnippets: [CodeLanguage : String]) {
        self.text = text
        self.codeSnippets = codeSnippets
    }
    
    var body: some View {
        ZStack {
            AppTheme.Colors.indigo.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(text)
                    .appFont(AppTheme.Fonts.largeTitle)
                
                CCPickerView(selectedSegment: $selectedSegment, array: programmingLanguages)
                    .padding(.vertical, 32)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        Text(codeSyntaxHighlight.highlightCode(for: code))
                            .font(.system(size: horizontalSizeClass == .compact ? 12.0 : 16.0, design: .monospaced))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxHeight: 840)
                .background(AppTheme.Colors.darkGray)
                .background(.ultraThickMaterial)
                .cornerRadius(16.0)
                .shadow(color: AppTheme.Colors.darkGray.opacity(0.25), radius: 10.0, x: 0, y: 20)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    CodeCheatsheetView(
        text: "Singly linked list", codeSnippets: Code.singlyLinkedListCodeSnippet
    )
}

