//
//  Int+.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import Foundation

extension Int: RandomElementGeneratable {
    static func getRandomElement() -> Int {
        Int.random(in: 1...100)
    }
}
