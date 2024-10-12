//
//  ArrayItem.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 07/10/24.
//

import Foundation

struct ArrayItem: Identifiable, Equatable {
    let id = UUID()
    let value: Int
    var position: CGFloat
    
    static func == (lhs: ArrayItem, rhs: ArrayItem) -> Bool {
        lhs.id == rhs.id && lhs.value == rhs.value && lhs.position == rhs.position
    }
}
