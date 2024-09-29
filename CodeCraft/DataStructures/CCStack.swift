//
//  CCStack.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import Foundation

public class CCStack<T>: ObservableObject {
    @Published var elements: [T] = []
    
    var isEmpy: Bool {
        elements.isEmpty
    }
    
    var length: Int {
        elements.count
    }
    
    func push(_ element: T) {
        elements.append(element)
    }
    
    func pop() -> T? {
        elements.popLast()
    }
    
    func peek() -> T? {
        elements.last
    }
}
