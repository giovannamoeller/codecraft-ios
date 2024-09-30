//
//  CCBinaryTree.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

class BinaryTree<T: Comparable & CustomStringConvertible>: ObservableObject {
    @Published var root: CCBinaryTreeNode<T>?
    
    func insert(_ value: T) {
        if root == nil {
            root = CCBinaryTreeNode(value)
        } else {
            insertNode(value, at: root!)
        }
    }
    
    private func insertNode(_ value: T, at node: CCBinaryTreeNode<T>) {
        if value < node.value {
            if node.left == nil {
                node.left = CCBinaryTreeNode(value)
            } else {
                insertNode(value, at: node.left!)
            }
        } else {
            if node.right == nil {
                node.right = CCBinaryTreeNode(value)
            } else {
                insertNode(value, at: node.right!)
            }
        }
    }
    
    func inorderTraversal() -> [T] {
        var result: [T] = []
        inorderTraversal(root, &result)
        return result
    }
    
    private func inorderTraversal(_ node: CCBinaryTreeNode<T>?, _ result: inout [T]) {
        guard let node = node else { return }
        inorderTraversal(node.left, &result)
        result.append(node.value)
        inorderTraversal(node.right, &result)
    }
}

