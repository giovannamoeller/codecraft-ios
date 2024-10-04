//
//  SinglyLinkedListTests.swift
//  CodeCraftTests
//
//  Created by Giovanna Moeller on 03/10/24.
//

import Testing

@testable import CodeCraft

class SinglyLinkedListTests {
    
    var list: SinglyLinkedList<Int>!
    
    @Test
    func testInsertAtHead() {
        list = SinglyLinkedList()
        list.insertAtHead(5)
        #expect(list.head?.value == 5)
        #expect(list.tail?.value == 5)
        #expect(list.length == 1)
        
        list.insertAtHead(10)
        #expect(list.head?.value == 10)
        #expect(list.tail?.value == 5)
        #expect(list.length == 2)
        
        list.insertAtHead(20)
        #expect(list.head?.value == 20)
        #expect(list.tail?.value == 5)
        #expect(list.length == 3)
    }
    
    @Test
    func testInsertAtTail() {
        list = SinglyLinkedList()
        list.insertAtTail(5)
        #expect(list.head?.value == 5)
        #expect(list.tail?.value == 5)
        #expect(list.length == 1)
        
        list.insertAtTail(10)
        #expect(list.head?.value == 5)
        #expect(list.tail?.value == 10)
        #expect(list.length == 2)
        
        list.insertAtTail(20)
        #expect(list.head?.value == 5)
        #expect(list.tail?.value == 20)
        #expect(list.length == 3)
    }
    
    @Test
    func testRemoveAtHead() {
        list = SinglyLinkedList()
        list.insertAtHead(5)
        list.insertAtHead(10)
        list.insertAtHead(20)
        // 20 - 10 - 5
        
        let removedValue = list.removeAtHead()
        #expect(removedValue == 20)
        #expect(list.head?.value == 10)
        #expect(list.tail?.value == 5)
        #expect(list.length == 2)
        
        _ = list.removeAtHead()
        _ = list.removeAtHead()
        #expect(list.head == nil)
        #expect(list.tail == nil)
        #expect(list.length == 0)
    }
    
    @Test
    func testRemoveAtTail() {
        list = SinglyLinkedList()
        list.insertAtTail(5)
        list.insertAtTail(10)
        list.insertAtTail(20)
        // 5 - 10 - 20
        
        let removedValue = list.removeAtTail()
        #expect(removedValue == 20)
        #expect(list.head?.value == 5)
        #expect(list.tail?.value == 10)
        #expect(list.length == 2)
        
        _ = list.removeAtTail()
        _ = list.removeAtTail()
        #expect(list.head == nil)
        #expect(list.tail == nil)
        #expect(list.length == 0)
    }
    
    @Test
    func testIsEmpty() {
        list = SinglyLinkedList()
        
        #expect(list.isEmpty)
        
        list.insertAtHead(5)
        #expect(!list.isEmpty)
        
        _ = list.removeAtHead()
        #expect(list.isEmpty)
    }
    
    @Test
    func testRemoveAll() {
        list = SinglyLinkedList()
        list.insertAtHead(5)
        list.insertAtHead(10)
        list.insertAtHead(15)
        
        list.removeAll()
        
        #expect(list.isEmpty)
        #expect(list.head == nil)
        #expect(list.tail == nil)
        #expect(list.length == 0)
    }
    
    @Test
    func testToArray() {
        list = SinglyLinkedList()
        list.insertAtTail(5)
        list.insertAtTail(10)
        list.insertAtTail(15)
        
        let array = list.toArray()
        #expect(array == [5, 10, 15])
    }
    
    @Test
    func testMultipleOperations() {
        list = SinglyLinkedList()
        list.insertAtHead(5)
        list.insertAtTail(10)
        list.insertAtHead(15)
        
        #expect(list.toArray() == [15, 5, 10])
        #expect(list.length == 3)
        
        _ = list.removeAtHead()
        _ = list.removeAtTail()
        
        #expect(list.toArray() == [5])
        #expect(list.length == 1)
        
        list.insertAtTail(20)
        #expect(list.toArray() == [5, 20])
        #expect(list.length == 2)
    }
    
    @Test
    func testDescriptionEmptyList() {
        list = SinglyLinkedList()
        #expect(list.description == "[]")
    }
    
    @Test
    func testDescriptionSingleElement() {
        list = SinglyLinkedList()
        list.insertAtHead(42)
        #expect(list.description == "[42]")
    }
    
    @Test
    func testDescriptionMultipleElements() {
        list = SinglyLinkedList()
        list.insertAtTail(1)
        list.insertAtTail(2)
        list.insertAtTail(3)
        #expect(list.description == "[1 -> 2 -> 3]")
    }
    
    @Test
    func testDescriptionAfterRemoval() {
        list = SinglyLinkedList()
        list.insertAtTail(1)
        list.insertAtTail(2)
        list.insertAtTail(3)
        _ = list.removeAtHead()
        #expect(list.description == "[2 -> 3]")
    }
    
    @Test
    func testDescriptionWithDifferentTypes() {
        let stringList = SinglyLinkedList<String>()
        stringList.insertAtTail("Hello")
        stringList.insertAtTail("World")
        #expect(stringList.description == "[Hello -> World]")
    }
}
