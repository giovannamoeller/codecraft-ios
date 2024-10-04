//
//  StackTests.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import Testing
@testable import CodeCraft

class StackTests {
    
    var stack: Stack<Int>!
    
    @Test
    func testPush() throws {
        stack = Stack()
        let element = StackElement(value: 10)
        stack.push(element)
        #expect(stack.length == 1)
    }
    
    @Test
    func testPeek() throws {
        stack = Stack()
        let element1 = StackElement(value: 10)
        let element2 = StackElement(value: 20)
        stack.push(element1)
        stack.push(element2)
        
        #expect(stack.peek()?.value == 20)
    }
    
    @Test
    func testPop() {
        stack = Stack()
        let element1 = StackElement(value: 5)
        let element2 = StackElement(value: 10)
        stack.push(element1)
        stack.push(element2)
        
        let poppedElement = stack.pop()
        
        #expect(poppedElement?.value == 10)
        #expect(stack.length == 1)
        #expect(stack.peek()?.value == 5)
    }
    
    @Test
    func testIsEmpty() {
        stack = Stack()
        #expect(stack.isEmpty)
        #expect(stack.length == 0)
        
        let element = StackElement(value: 5)
        stack.push(element)
        
        #expect(!stack.isEmpty)
        #expect(stack.length > 0)
        
        _ = stack.pop()
        
        #expect(stack.isEmpty)
        #expect(stack.length == 0)
    }
    
    @Test
    func testLength() {
        stack = Stack()
        #expect(stack.length == 0)
        
        stack.push(StackElement(value: 5))
        #expect(stack.length == 1)
        
        stack.push(StackElement(value: 10))
        #expect(stack.length == 2)
        
        _ = stack.pop()
        #expect(stack.length == 1)
    }
    
    @Test
    func testPeekEmptyStack() {
        stack = Stack()
        #expect(stack.peek() == nil)
    }
    
    @Test
    func testPopEmptyStack() {
        stack = Stack()
        #expect(stack.pop() == nil)
    }
    
    @Test
    func testRemoveAll() {
        stack = Stack()
        stack.push(StackElement(value: 5))
        stack.push(StackElement(value: 10))
        stack.push(StackElement(value: 15))
        
        stack.removeAll()
        
        #expect(stack.isEmpty)
        #expect(stack.length == 0)
        #expect(stack.peek() == nil)
    }
    
    @Test
    func testMultipleOperations() {
        stack = Stack()
        stack.push(StackElement(value: 5))
        stack.push(StackElement(value: 10))
        
        #expect(stack.pop()?.value == 10)
        
        stack.push(StackElement(value: 15))
        
        #expect(stack.peek()?.value == 15)
        #expect(stack.length == 2)
        
        #expect(stack.pop()?.value == 15)
        #expect(stack.pop()?.value == 5)
        #expect(stack.pop() == nil)
        
        #expect(stack.isEmpty)
    }
}
