//
//  Utils.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 30/09/24.
//

import SwiftUI

func updateOnMainThread(closure: @escaping () -> Void) {
    DispatchQueue.main.async {
        withAnimation(.spring(duration: 0.5, bounce: 0.5)) {
            closure()
        }
    }
}

func delay(for seconds: Double = 0.5, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}

func getRandomElement(from: Int = 1, to: Int = 100) -> Int {
    Int.random(in: from..<to)
}
