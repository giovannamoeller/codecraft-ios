//
//  InteractiveDoublyLinkedListView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct InteractiveDoublyLinkedListView: View {
    var body: some View {
        InteractiveLinkedListView<DoublyLinkedList<Int>, DoublyNodeView>(
            linkedList: DoublyLinkedList<Int>(),
            title: "Visualize how a doubly linked list works",
            description: "Observe how the doubly linked list changes as you perform operations below.",
            usageExample: UsageExample.doublyLinkedList
        )
    }
}

#Preview {
    InteractiveDoublyLinkedListView()
}
