//
//  DoublyLinkedList.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

public class DoublyLinkedList<T: Hashable>: ObservableObject, LinkedListProtocol {
    public typealias Element = T

    @Published var head: DoublyNode<T>?
    @Published var tail: DoublyNode<T>?
    @Published var length: Int = 0
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public func insertAtHead(_ value: T) {
        let newNode = DoublyNode(value)
        guard !isEmpty else {
            head = newNode
            tail = newNode
            length += 1
            return
        }
        newNode.next = head
        head?.prev = newNode
        head = newNode
        length += 1
    }
    
    public func insertAtTail(_ value: T) {
        let newNode = DoublyNode(value)
        guard !isEmpty else {
            head = newNode
            tail = newNode
            length += 1
            return
        }
        tail?.next = newNode
        newNode.prev = tail
        tail = newNode
        length += 1
    }
    
    public func removeAtHead() -> T? {
        guard !isEmpty else { return nil }
        let removedValue = head?.value
        head = head?.next
        head?.prev = nil
        if head == nil {
            tail = nil
        }
        length -= 1
        return removedValue
    }
    
    public func removeAtTail() -> T? {
        guard !isEmpty else { return nil }
        let removedValue = tail?.value
        tail = tail?.prev
        tail?.next = nil
        if tail == nil {
            head = nil
        }
        length -= 1
        return removedValue
    }
    
    public func removeAll() {
        guard !isEmpty else { return }
        head = nil
        tail = nil
        length = 0
    }
    
    public func toArray() -> [T] {
        var result: [T] = []
        var current = head
        while let node = current {
            result.append(node.value)
            current = node.next
        }
        return result
    }
}
