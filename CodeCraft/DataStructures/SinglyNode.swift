//
//  SinglyNode.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import Foundation

public class SinglyNode<T: Equatable>: Equatable {
    var value: T
    var next: SinglyNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
    
    // Conforming to Equatable protocol
    public static func == (lhs: SinglyNode<T>, rhs: SinglyNode<T>) -> Bool {
        lhs.value == rhs.value && lhs.next == rhs.next
    }
}
