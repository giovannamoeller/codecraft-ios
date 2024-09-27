//
//  CCSinglyNode.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import Foundation

public class CCSinglyNode<T: Equatable>: Equatable {
    var value: T
    var next: CCSinglyNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
    
    // Conforming to Equatable protocol
    public static func == (lhs: CCSinglyNode<T>, rhs: CCSinglyNode<T>) -> Bool {
        lhs.value == rhs.value && lhs.next == rhs.next
    }
}
