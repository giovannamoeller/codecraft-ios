//
//  LinkedListNodeView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import SwiftUI

struct LinkedListNodeView<Element: Hashable>: View {
    let element: Element
    let isHead: Bool
    let isTail: Bool
    let arrowView: AnyView
    
    private var headOrTailText: String {
        isHead && isTail ? "Head/Tail" : (isHead ? "Head" : (isTail ? "Tail" : ""))
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.lightLavender)
                    .frame(width: 64, height: 64)
                ResponsiveTextView(text: "\(String(describing: element))", style: .subtitle, alignment: .center)
                ResponsiveTextView(text: headOrTailText, style: .bodyRegular, alignment: .center, foregroundStyle: .white)
                    .offset(y: -52)
            }
            if !isTail {
                arrowView
            }
        }
    }
}

#Preview {
    LinkedListNodeView(
        element: 1,
        isHead: true,
        isTail: false,
        arrowView: AnyView(
            Image(systemName: "arrow.forward")
                .foregroundStyle(.white)
        )
    )
}
