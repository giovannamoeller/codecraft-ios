//
//  DoublyNode.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

public class DoublyNode<T: Equatable>: Equatable {
    var value: T
    var next: DoublyNode<T>?
    var prev: DoublyNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
    
    public static func == (lhs: DoublyNode<T>, rhs: DoublyNode<T>) -> Bool {
        lhs.value == rhs.value && lhs.next == rhs.next && lhs.prev == rhs.prev
    }
}
