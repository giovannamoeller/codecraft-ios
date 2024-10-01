//
//  Utils.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 30/09/24.
//

import Foundation

func getRandomElement(from: Int = 1, to: Int = 100) -> Int {
    Int.random(in: from..<to)
}

func executeAfter(_ seconds: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}
