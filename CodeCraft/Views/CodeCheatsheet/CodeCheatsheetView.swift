//
//  CodeCheatsheetView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

struct CodeCheatsheetView: View {
    
    let codeSnippets: [CodeLanguage: String]
    private var codeSyntaxHighlight: CodeSyntaxHighlight = CodeSyntaxHighlight()
    private var code: String {
        codeSnippets[programmingLanguages[selectedSegment]] ?? ""
    }
    
    @State private var programmingLanguages: [CodeLanguage] = CodeLanguage.allCases
    @State private var selectedLanguage: CodeLanguage = .python
    @State private var selectedSegment: Int = 0
    
    init(codeSnippets: [CodeLanguage : String]) {
        self.codeSnippets = codeSnippets
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CCPickerView(selectedSegment: $selectedSegment, array: programmingLanguages)
                .padding(.bottom)
            
            VStack {
                ScrollView {
                    Text(codeSyntaxHighlight.highlightCode(for: code))
                        .font(.system(size: 16, design: .monospaced))
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 840, alignment: .topLeading)
            .padding()
            .background(AppTheme.Colors.lightBrown)
            .cornerRadius(16.0)
            .shadow(color: AppTheme.Colors.mediumBrown.opacity(0.25), radius: 10.0, x: 0, y: 20)
        }
        .padding(.horizontal, 32)
        .padding(.vertical)
    }
}

#Preview {
    CodeCheatsheetView(
        codeSnippets: Code.arrayCodeSnippet
    )
}

