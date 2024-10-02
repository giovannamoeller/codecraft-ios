//
//  InteractiveSinglyLinkedListView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct InteractiveSinglyLinkedListView: View {
    var body: some View {
        InteractiveLinkedListView<SinglyLinkedList<Int>, SinglyNodeView>(
            linkedList: SinglyLinkedList<Int>(),
            title: "Visualize how a singly linked list works",
            description: "Observe how the linked list changes as you perform operations below.",
            usageExample: UsageExample.singlyLinkedList
        )
    }
}

#Preview {
    InteractiveSinglyLinkedListView()
}
