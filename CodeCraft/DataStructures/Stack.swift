//
//  CCStack.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import Foundation

public class StackElement<T>: Identifiable {
    public var id: UUID
    public var value: T
    
    public init(value: T) {
        self.id = UUID()
        self.value = value
    }
}

public class Stack<T>: ObservableObject {
    @Published var elements: [StackElement<T>] = []
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var length: Int {
        elements.count
    }
    
    func push(_ element: StackElement<T>) {
        elements.append(element)
    }
    
    func pop() -> StackElement<T>? {
        elements.popLast()
    }
    
    func peek() -> StackElement<T>? {
        elements.last
    }
    
    func removeAll() {
        elements.removeAll()
    }
}
