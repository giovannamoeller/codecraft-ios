//
//  Code.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import Foundation

enum Code {
    static let arrayCodeSnippet: [CodeLanguage: String] = [
        .python: """
        # Python array example
        fruits = ["apple", "banana", "cherry"]
        print(fruits[0])  # Output: apple
        fruits.append("date")
        print(len(fruits))  # Output: 4
        """,
        .java: """
        // Java array example
        String[] fruits = {"apple", "banana", "cherry"};
        System.out.println(fruits[0]);  // Output: apple
        fruits = Arrays.copyOf(fruits, fruits.length + 1);
        fruits[fruits.length - 1] = "date";
        System.out.println(fruits.length);  // Output: 4
        """,
        .swift: """
        // Swift array example
        var fruits = ["apple", "banana", "cherry"]
        print(fruits[0])  // Output: apple
        fruits.append("date")
        print(fruits.count)  // Output: 4
        """,
        .cPlusPlus: """
        // C++ array example
        std::vector<std::string> fruits = {"apple", "banana", "cherry"};
        std::cout << fruits[0] << std::endl;  // Output: apple
        fruits.push_back("date");
        std::cout << fruits.size() << std::endl;  // Output: 4
        """
    ]
    
    static let singlyLinkedListCodeSnippet: [CodeLanguage: String] = [
        .python: """
        class Node:
            def __init__(self, value):
                self.value = value
                self.next = None

        class SinglyLinkedList:
            def __init__(self):
                self.head = None
                self.tail = None

            def insert_head(self, value):
                new_node = Node(value)
                if not self.head:
                    self.head = new_node
                    self.tail = new_node
                else:
                    new_node.next = self.head
                    self.head = new_node

            def insert_tail(self, value):
                new_node = Node(value)
                if not self.tail:
                    self.head = new_node
                    self.tail = new_node
                else:
                    self.tail.next = new_node
                    self.tail = new_node

            def remove_head(self):
                if not self.head:
                    return None
                
                removed_value = self.head.value
                self.head = self.head.next
                if not self.head:
                    self.tail = None
                return removed_value

            def remove_tail(self):
                if not self.head:
                    return None
                
                if self.head == self.tail:
                    removed_value = self.head.value
                    self.head = None
                    self.tail = None
                    return removed_value
                
                current = self.head
                while current.next != self.tail:
                    current = current.next
                
                removed_value = self.tail.value
                self.tail = current
                self.tail.next = None
                return removed_value

            def print_list(self):
                current = self.head
                while current:
                    print(current.value, end=" -> ")
                    current = current.next
                print("None")
        """,
        .java: """
        public class SinglyLinkedList<T> {
            private class Node {
                T value;
                Node next;

                Node(T value) {
                    this.value = value;
                    this.next = null;
                }
            }

            private Node head;
            private Node tail;

            public void insertHead(T value) {
                Node newNode = new Node(value);
                if (head == null) {
                    head = newNode;
                    tail = newNode;
                } else {
                    newNode.next = head;
                    head = newNode;
                }
            }

            public void insertTail(T value) {
                Node newNode = new Node(value);
                if (tail == null) {
                    head = newNode;
                    tail = newNode;
                } else {
                    tail.next = newNode;
                    tail = newNode;
                }
            }

            public T removeHead() {
                if (head == null) {
                    return null;
                }
                
                T removedValue = head.value;
                head = head.next;
                if (head == null) {
                    tail = null;
                }
                return removedValue;
            }

            public T removeTail() {
                if (head == null) {
                    return null;
                }
                
                if (head == tail) {
                    T removedValue = head.value;
                    head = null;
                    tail = null;
                    return removedValue;
                }
                
                Node current = head;
                while (current.next != tail) {
                    current = current.next;
                }
                
                T removedValue = tail.value;
                tail = current;
                tail.next = null;
                return removedValue;
            }

            public void printList() {
                Node current = head;
                while (current != null) {
                    System.out.print(current.value + " -> ");
                    current = current.next;
                }
                System.out.println("null");
            }
        }
        """,
        .swift: """
        class Node<T> {
            var value: T
            var next: Node?
            
            init(value: T) {
                self.value = value
            }
        }

        class SinglyLinkedList<T> {
            private var head: Node<T>?
            private var tail: Node<T>?
            
            func insertHead(_ value: T) {
                let newNode = Node(value: value)
                if head == nil {
                    head = newNode
                    tail = newNode
                } else {
                    newNode.next = head
                    head = newNode
                }
            }
            
            func insertTail(_ value: T) {
                let newNode = Node(value: value)
                if tail == nil {
                    head = newNode
                    tail = newNode
                } else {
                    tail?.next = newNode
                    tail = newNode
                }
            }
            
            func removeHead() -> T? {
                guard let headNode = head else {
                    return nil
                }
                
                head = headNode.next
                if head == nil {
                    tail = nil
                }
                
                return headNode.value
            }
            
            func removeTail() -> T? {
                guard let tailNode = tail else {
                    return nil
                }
                
                if head === tail {
                    let value = head?.value
                    head = nil
                    tail = nil
                    return value
                }
                
                var current = head
                while current?.next !== tail {
                    current = current?.next
                }
                
                let value = tailNode.value
                current?.next = nil
                tail = current
                
                return value
            }
            
            func printList() {
                var current = head
                while let node = current {
                    print(node.value, terminator: " -> ")
                    current = node.next
                }
                print("nil")
            }
        }
        """,
        .cPlusPlus: """
        #include <iostream>

        template<typename T>
        class SinglyLinkedList {
        private:
            struct Node {
                T value;
                Node* next;
                Node(T val) : value(val), next(nullptr) {}
            };

            Node* head;
            Node* tail;

        public:
            SinglyLinkedList() : head(nullptr), tail(nullptr) {}

            ~SinglyLinkedList() {
                while (head) {
                    Node* temp = head;
                    head = head->next;
                    delete temp;
                }
            }

            void insertHead(T value) {
                Node* newNode = new Node(value);
                if (!head) {
                    head = tail = newNode;
                } else {
                    newNode->next = head;
                    head = newNode;
                }
            }

            void insertTail(T value) {
                Node* newNode = new Node(value);
                if (!tail) {
                    head = tail = newNode;
                } else {
                    tail->next = newNode;
                    tail = newNode;
                }
            }

            T removeHead() {
                if (!head) {
                    throw std::runtime_error("List is empty");
                }
                
                Node* temp = head;
                T removedValue = temp->value;
                head = head->next;
                if (!head) {
                    tail = nullptr;
                }
                delete temp;
                return removedValue;
            }

            T removeTail() {
                if (!head) {
                    throw std::runtime_error("List is empty");
                }
                
                if (head == tail) {
                    T removedValue = head->value;
                    delete head;
                    head = tail = nullptr;
                    return removedValue;
                }
                
                Node* current = head;
                while (current->next != tail) {
                    current = current->next;
                }
                
                T removedValue = tail->value;
                delete tail;
                tail = current;
                tail->next = nullptr;
                return removedValue;
            }

            void printList() const {
                Node* current = head;
                while (current) {
                    std::cout << current->value << " -> ";
                    current = current->next;
                }
                std::cout << "nullptr" << std::endl;
            }
        };
        """
    ]
}
