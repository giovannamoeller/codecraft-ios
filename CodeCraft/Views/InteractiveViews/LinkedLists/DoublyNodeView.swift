//
//  DoublyNodeView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import SwiftUI

struct DoublyNodeView<Element: Hashable>: View, LinkedListNodeViewProtocol {
    let element: Element
    let isHead: Bool
    let isTail: Bool
    
    init(element: Element, isHead: Bool = false, isTail: Bool = false) {
        self.element = element
        self.isHead = isHead
        self.isTail = isTail
    }
    
    var body: some View {
        LinkedListNodeView(
            element: element,
            isHead: isHead,
            isTail: isTail,
            arrowView: AnyView(
                VStack(spacing: 4) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 4)
            )
        )
    }
}

#Preview {
    DoublyNodeView(element: 10)
}
