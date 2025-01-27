//
//  Queue.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import Foundation

public class QueueElement<T>: Identifiable {
    public var id: UUID
    public var value: T
    
    public init(value: T) {
        self.id = UUID()
        self.value = value
    }
}

public class Queue<T>: ObservableObject {
    @Published var elements: [QueueElement<T>] = []
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var length: Int {
        elements.count
    }
    
    func enqueue(_ element: QueueElement<T>) {
        elements.append(element)
    }
    
    func dequeue() -> QueueElement<T>? {
        if isEmpty { return nil }
        return elements.removeFirst()
    }
    
    func front() -> QueueElement<T>? {
        elements.first
    }
    
    func removeAll() {
        elements.removeAll()
    }
}
