//
//  CodeSyntaxHighlight.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

struct CodeSyntaxHighlight {
    private let patterns: [String: Color] = [
        // Keywords for Swift
        "\\b(let|var|func|if|else|for|while|return|class|struct|enum|protocol|extension|import|in|self|init)\\b": .blue,
        
        // Keywords for Python
        "\\b(def|class|if|else|elif|for|while|return|import|from|as|with|try|except|finally|raise|yield|self|True|False|None|lambda)\\b": .blue,
        
        // Keywords for Java
        "\\b(public|private|protected|class|interface|extends|implements|new|if|else|for|while|return|import|package|this|void|static|final|try|catch|finally|throw)\\b": .blue,
        
        // Keywords for C++
        "\\b(int|float|double|char|void|bool|if|else|for|while|return|class|struct|public|private|protected|new|delete|this|namespace|using|try|catch|throw)\\b": .blue,
        
        // Types (Swift, Python, Java, C++)
        "\\b(Int|Double|String|Bool|Array|Dictionary|Set|Optional|Any|Object|void|int|float|double|char|bool|List|Map|Set|void|boolean)\\b": .purple,
        
        // Strings (all languages)
        "\".*?\"": .green,    // Matches anything in double quotes
        "\'.*?\'": .green,    // Matches anything in single quotes
        
        // Numbers (all languages)
        "\\b\\d+\\b": .orange,  // Matches integers
        "\\b\\d+\\.\\d+\\b": .orange,  // Matches floating-point numbers
        
        // Function names (Swift, Python, Java, C++)
        "\\b([a-zA-Z_][a-zA-Z0-9_]*)\\s*(?=\\()": .pink,  // Matches functions names followed by parentheses
        
        // Properties (Swift/Python)
        "\\bself\\.[a-zA-Z_][a-zA-Z0-9_]*\\b": .cyan,  // Matches properties prefixed with `self.` in Swift/Python
        
        // Properties (Java)
        "\\bthis\\.[a-zA-Z_][a-zA-Z0-9_]*\\b": .cyan,  // Matches properties prefixed with `this.` in Java
        
        // Properties (C++)
        "\\bthis->\\b[a-zA-Z_][a-zA-Z0-9_]*": .cyan,  // Matches properties prefixed with `this->` in C++
        
        // Comments (Swift, Java, C++)
        "//.*": .gray,        // Single-line comments
        "/\\*.*?\\*/": .gray, // Multi-line comments
        
        // Comments (Python)
        "#.*": .gray          // Single-line comments
    ]
    
    func highlightCode(for code: String) -> AttributedString {
        var attributedString = AttributedString(code)
        for (pattern, color) in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern, options: [.anchorsMatchLines]) {
                let range = NSRange(code.startIndex..<code.endIndex, in: code)
                regex.enumerateMatches(in: code, options: [], range: range) { match, _, _ in
                    if let matchRange = match?.range {
                        if let range = Range(matchRange, in: attributedString) {
                            attributedString[range].foregroundColor = color
                        }
                    }
                }
            }
        }
        
        return attributedString
    }
}
