//
//  QueueTests.swift
//  CodeCraftTests
//
//  Created by Giovanna Moeller on 03/10/24.
//

import Testing
@testable import CodeCraft

class QueueTests {
    
    var queue: Queue<Int>!
    
    @Test
    func testEnqueue() {
        queue = Queue()
        let element = QueueElement(value: 5)
        queue.enqueue(element)
        
        #expect(queue.length == 1)
    }
    
    @Test
    func testFront() {
        queue = Queue()
        let element = QueueElement(value: 5)
        queue.enqueue(element)
        
        #expect(queue.front()?.value == 5)
    }
    
    @Test
    func testDequeue() {
        queue = Queue()
        let element1 = QueueElement(value: 5)
        let element2 = QueueElement(value: 10)
        queue.enqueue(element1)
        queue.enqueue(element2)
        
        let dequeuedElement = queue.dequeue()
        
        #expect(dequeuedElement?.value == 5)
        #expect(queue.length == 1)
        #expect(queue.front()?.value == 10)
    }
    
    @Test
    func testIsEmpty() {
        queue = Queue()
        #expect(queue.isEmpty)
        
        queue.enqueue(QueueElement(value: 5))
        #expect(!queue.isEmpty)
        
        _ = queue.dequeue()
        #expect(queue.isEmpty)
    }
    
    @Test
    func testLength() {
        queue = Queue()
        #expect(queue.length == 0)
        
        queue.enqueue(QueueElement(value: 5))
        #expect(queue.length == 1)
        
        queue.enqueue(QueueElement(value: 10))
        #expect(queue.length == 2)
        
        _ = queue.dequeue()
        #expect(queue.length == 1)
    }
    
    @Test
    func testFrontEmptyQueue() {
        queue = Queue()
        #expect(queue.front() == nil)
    }
    
    @Test
    func testDequeueEmptyQueue() {
        queue = Queue()
        #expect(queue.dequeue() == nil)
    }
    
    @Test
    func testRemoveAll() {
        queue = Queue()
        queue.enqueue(QueueElement(value: 5))
        queue.enqueue(QueueElement(value: 10))
        queue.enqueue(QueueElement(value: 15))
        
        queue.removeAll()
        
        #expect(queue.isEmpty)
        #expect(queue.length == 0)
        #expect(queue.front() == nil)
    }
    
    @Test
    func testMultipleOperations() {
        queue = Queue()
        queue.enqueue(QueueElement(value: 5))
        queue.enqueue(QueueElement(value: 10))
        
        #expect(queue.dequeue()?.value == 5)
        
        queue.enqueue(QueueElement(value: 15))
        
        #expect(queue.front()?.value == 10)
        #expect(queue.length == 2)
        
        #expect(queue.dequeue()?.value == 10)
        #expect(queue.dequeue()?.value == 15)
        #expect(queue.dequeue() == nil)
        
        #expect(queue.isEmpty)
    }
    
    @Test
    func testFIFOOrder() {
        queue = Queue()
        let values = [1, 2, 3, 4, 5]
        
        for value in values {
            queue.enqueue(QueueElement(value: value))
        }
        
        for expectedValue in values {
            #expect(queue.dequeue()?.value == expectedValue)
        }
    }
}
