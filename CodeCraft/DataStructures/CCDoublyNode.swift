//
//  CCDoublyNode.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//


public class CCDoublyNode<T: Equatable>: Equatable {
    var value: T
    var next: CCDoublyNode<T>?
    var prev: CCDoublyNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
    
    public static func == (lhs: CCDoublyNode<T>, rhs: CCDoublyNode<T>) -> Bool {
        lhs.value == rhs.value && lhs.next == rhs.next && lhs.prev == rhs.prev
    }
}
