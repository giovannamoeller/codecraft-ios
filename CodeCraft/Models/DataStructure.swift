//
//  DataStructure.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import Foundation

enum DataStructure {
    case array
    case singlyLinkedList
    case doublyLinkedList
    case stack
    case queue
    
    var title: String {
        switch self {
        case .array: return "Array"
        case .singlyLinkedList: return "Singly Linked List"
        case .doublyLinkedList: return "Doubly Linked List"
        case .stack: return "Stack"
        case .queue: return "Queue"
        }
    }
    
    var sectionNumber: Int {
        switch self {
        case .array: return 0
        case .singlyLinkedList: return 1
        case .doublyLinkedList: return 2
        case .stack: return 3
        case .queue: return 4
        }
    }
}
