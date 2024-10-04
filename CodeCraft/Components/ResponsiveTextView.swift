//
//  ResponsiveTextView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct ResponsiveTextView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let text: String
    let style: ResponsiveFontStyle
    let alignment: Alignment
    let foregroundStyle: Color
    
    init(text: String,
         style: ResponsiveFontStyle,
         alignment: Alignment = .leading,
         foregroundStyle: Color = .primary) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.foregroundStyle = foregroundStyle
    }
    
    var body: some View {
        Text(LocalizedStringKey(text))
            .font(horizontalSizeClass == .compact ? style.compact.font : style.regular.font)
            .frame(maxWidth: .infinity, alignment: alignment)
            .foregroundStyle(foregroundStyle)
    }
}

#Preview {
    ResponsiveTextView(text: "Hello, World!", style: .title)
}
