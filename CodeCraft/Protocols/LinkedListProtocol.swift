//
//  LinkedListProtocol.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import Foundation

protocol LinkedListProtocol: ObservableObject {
    associatedtype Element: Hashable
    var isEmpty: Bool { get }
    var length: Int { get }
    func toArray() -> [Element]
    func insertAtHead(_ element: Element)
    func insertAtTail(_ element: Element)
    func removeAtHead() -> Element?
    func removeAtTail() -> Element?
    func removeAll()
}
