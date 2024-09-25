//
//  CCDynamicArray.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import Foundation

public class CCDynamicArray<T>: ObservableObject {
    @Published public var elements: [T]
    
    init(count: Int, randomGenerator: () -> T) {
        self.elements = (0..<count).map { _ in randomGenerator() }
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    public func insertAtLastPosition(_ element: T) {
        elements.append(element)
    }
    
    public func insertAtFirstPosition(_ element: T) {
        elements.insert(element, at: 0)
    }
    
    public func insertAt(index: Int, element: T) {
        guard index >= 0, index <= count else { return }
        elements.insert(element, at: index)
    }
    
    public func removeAtLastPosition() -> T? {
        elements.removeLast()
    }
    
    public func removeAtFirstPosition() -> T? {
        elements.removeFirst()
    }
    
    public func removeAt(index: Int) -> T? {
        guard index >= 0, index < count else { return nil }
        return elements.remove(at: index)
    }
    
    public func getElement(at index: Int) -> T? {
        guard index >= 0, index < count else { return nil }
        return elements[index]
    }
    
}
