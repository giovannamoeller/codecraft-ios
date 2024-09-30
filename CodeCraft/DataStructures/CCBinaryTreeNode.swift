//
//  CCBinaryTreeNode.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

class CCBinaryTreeNode<T: Comparable & CustomStringConvertible>: Identifiable, ObservableObject {
    let id = UUID()
    @Published var value: T
    @Published var left: BinaryTreeNode?
    @Published var right: BinaryTreeNode?
    
    init(_ value: T) {
        self.value = value
    }
}
