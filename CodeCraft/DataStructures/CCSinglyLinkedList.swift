//
//  CCSinglyLinkedList.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import Foundation

public class CCSinglyLinkedList<T: Equatable>: ObservableObject {
    @Published var head: CCSinglyNode<T>?
    @Published var tail: CCSinglyNode<T>?
    @Published var length: Int = 0
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public func insertAtHead(_ value: T) {
        let newNode = CCSinglyNode(value)
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
        let newNode = CCSinglyNode(value)
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
        head = head?.next
        if head == nil {
            tail = nil
        }
        length -= 1
        return head?.value
    }
    
    public func removeAtTail() -> T? {
        guard !isEmpty else { return nil }
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
        return tail?.value
    }
    
    public func printList() {
        var currentNode = head
        while currentNode != nil {
            if let value = currentNode?.value {
                print("\(value) \(currentNode?.next == nil ? " " : " -> ")")
            }
            currentNode = currentNode?.next
        }
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
