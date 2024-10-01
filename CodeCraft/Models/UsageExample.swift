//
//  UsageExample.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import Foundation

enum UsageExample {
    static let singlyLinkedList: [GridData] = [
        GridData(icon: "link", title: "Node-based", description: "Linked lists consist of nodes, each containing data and a reference to the next node."),
        GridData(icon: "arrow.right", title: "Sequential access", description: "Elements are accessed sequentially, starting from the head."),
        GridData(icon: "plus.circle", title: "Dynamic size", description: "Linked lists can grow or shrink dynamically as needed."),
        GridData(icon: "bolt", title: "Efficient insertions", description: "Inserting elements at the beginning or end is very efficient (O(1) time)."),
    ]
}
