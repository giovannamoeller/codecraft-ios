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
                Image(systemName: "arrow.left.and.right")
                    .foregroundColor(.white)
            )
        )
    }
}

#Preview {
    DoublyNodeView(element: 10)
}
