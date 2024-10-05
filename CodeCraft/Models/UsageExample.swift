//
//  UsageExample.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import Foundation

enum UsageExample {
    static let array: [GridData] = [
        GridData(icon: "info.circle", title: "Zero-indexed", description: "Arrays are zero-indexed: The first element is at index 0."),
        GridData(icon: "info.circle", title: "Unique index", description: "Each element has a unique index: Used to access or modify the element."),
        GridData(icon: "info.circle", title: "Fixed and Dynamic", description: "Arrays have a fixed size in some languages, but can be dynamic in others."),
        GridData(icon: "info.circle", title: "Common operations", description: "Common operations: Insertion, deletion, and accessing elements."),
    ]
    
    static let singlyLinkedList: [GridData] = [
        GridData(icon: "link", title: "Node-based", description: "Linked lists consist of nodes, each containing data and a reference to the next node."),
        GridData(icon: "arrow.right", title: "Sequential access", description: "Elements are accessed sequentially, starting from the head."),
        GridData(icon: "plus.circle", title: "Dynamic size", description: "Linked lists can grow or shrink dynamically as needed."),
        GridData(icon: "bolt", title: "Efficient insertions", description: "Inserting elements at the beginning or end is very efficient (O(1) time)."),
    ]
    
    static let doublyLinkedList: [GridData] = [
        GridData(icon: "link", title: "Node-based", description: "Doubly linked lists consist of nodes, each containing data and references to both the next and previous nodes."),
        GridData(icon: "arrow.left.arrow.right", title: "Bidirectional", description: "Elements can be traversed in both directions."),
        GridData(icon: "plus.circle", title: "Dynamic size", description: "Doubly linked lists can grow or shrink dynamically as needed."),
        GridData(icon: "bolt", title: "Efficient insertions and deletions", description: "Inserting or removing elements at any position is very efficient (O(1) time)."),
    ]
    
    static let queue: [GridData] = [
        GridData(icon: "person.3", title: "First In, First Out (FIFO)", description: "Like a line of people waiting, the first person to join is the first to leave."),
        GridData(icon: "printer", title: "Printer Queue", description: "Print jobs are processed in the order they are received."),
        GridData(icon: "bus", title: "Bus Stop", description: "People board the bus in the order they arrived at the stop."),
        GridData(icon: "arrow.left.arrow.right", title: "Data Buffer", description: "In computing, queues are used to manage data flow between processes."),
    ]
    
    static let stack: [GridData] = [
        GridData(icon: "tray.and.arrow.up.fill", title: "Last In, First Out (LIFO)", description: "Like a stack of plates, the last item added is the first one removed."),
        GridData(icon: "book.closed.fill", title: "Browser History", description: "Navigating back through web pages works like a stack."),
        GridData(icon: "arrow.uturn.backward", title: "Undo Functionality", description: "The undo feature in many applications uses a stack to keep track of actions."),
        GridData(icon: "cpu", title: "Function Call Stack", description: "Computer memory uses a stack to manage function calls and returns."),
    ]
    
    static let bubbleSort: [GridData] = [
        GridData(icon: "arrow.up.arrow.down", title: "Adjacent Comparisons", description: "Repeatedly steps through the list, compares adjacent elements and swaps them if they're in the wrong order."),
        GridData(icon: "chart.bar.fill", title: "Ideal for Small Arrays", description: "Best suited for sorting small arrays or lists where simplicity is more important than efficiency."),
        GridData(icon: "chart.bar", title: "Time Complexity", description: "O(n^2) time complexity in the average and worst cases, where n is the number of items."),
        GridData(icon: "square.and.pencil", title: "In-place Sorting", description: "Sorts the array in-place, requiring only a constant amount O(1) of additional memory space."),
    ]
    
    static let insertionSort: [GridData] = [
        GridData(icon: "arrow.right.to.line", title: "Build Sorted Portion", description: "Builds the final sorted array one item at a time, by inserting each element into its correct position."),
        GridData(icon: "chart.bar.fill", title: "Efficient for Small Arrays", description: "Performs well for small data sets or partially sorted arrays."),
        GridData(icon: "chart.bar", title: "Time Complexity", description: "O(n^2) time complexity in the average and worst cases, but can be O(n) in the best case."),
        GridData(icon: "square.and.pencil", title: "In-Place Algorithm", description: "Sorts the array in-place, requiring only a constant amount O(1) of additional memory space."),
    ]
    
    static let selectionSort: [GridData] = [
        GridData(icon: "arrow.up.arrow.down", title: "Find Minimum", description: "Repeatedly finds the minimum element from the unsorted portion and places it at the beginning."),
        GridData(icon: "chart.bar.fill", title: "Simple Implementation", description: "Easy to understand and implement, but not efficient for large data sets."),
        GridData(icon: "chart.bar", title: "Time Complexity", description: "O(n^2) time complexity in all cases, where n is the number of items."),
        GridData(icon: "square.and.pencil", title: "In-Place Sorting", description: "Sorts the array in-place, requiring only a constant amount O(1) of additional memory space."),
    ]
}
