//
//  SinglyLinkedList.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import Foundation

public class SinglyLinkedList<T: Hashable>: ObservableObject, LinkedListProtocol {
    public typealias Element = T
    
    @Published var head: SinglyNode<T>?
    @Published var tail: SinglyNode<T>?
    @Published var length: Int = 0
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var description: String {
        guard !isEmpty else { return "[]" }
        var description: String = "["
        var currentNode = head
        while let node = currentNode {
            description += "\(node.value)"
            if node.next != nil {
                description += " -> "
            }
            currentNode = node.next
        }
        return description + "]"
    }
    
    public func insertAtHead(_ value: T) {
        let newNode = SinglyNode(value)
        guard !isEmpty else {
            head = newNode
            tail = newNode
            length += 1
            return
        }
        newNode.next = head
        head = newNode
        length += 1
    }
    
    public func insertAtTail(_ value: T) {
        let newNode = SinglyNode(value)
        guard !isEmpty else {
            head = newNode
            tail = newNode
            length += 1
            return
        }
        tail?.next = newNode
        tail = newNode
        length += 1
    }
    
    public func removeAtHead() -> T? {
        guard !isEmpty else { return nil }
        let removedValue = head?.value
        head = head?.next
        if head == nil {
            tail = nil
        }
        length -= 1
        return removedValue
    }
    
    public func removeAtTail() -> T? {
        guard !isEmpty else { return nil }
        let removedValue = tail?.value
        if head == tail {
            head = nil
            tail = nil
        } else {
            var current = head
            while current?.next !== tail {
                current = current?.next
            }
            current?.next = nil
            tail = current
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
