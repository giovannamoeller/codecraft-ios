//
//  LinkedListNodeViewProtocol.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import SwiftUI

protocol LinkedListNodeViewProtocol: View {
    associatedtype Element
    init(element: Element, isHead: Bool, isTail: Bool)
}
