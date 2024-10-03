//
//  Utils.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 30/09/24.
//

import SwiftUI

func generateRandomArray() -> [Int] {
    (1...5).map( {_ in Int.random(in: 1..<100)} )
}

func getRandomElement(from: Int = 1, to: Int = 100) -> Int {
    Int.random(in: from..<to)
}

func executeAfter(_ seconds: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}

func executeOnMainThread(_ closure: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        closure()
    }
}

func updateOnMainThreadWithDefaultAnimation(_ animationDuration: Double = 0.5, _ closure: @escaping () -> Void) async {
    withAnimation(.spring(duration: animationDuration, bounce: 0.3)) {
        closure()
    }
}

func updateOnMainThread(_ closure: @escaping () -> Void) async {
    await MainActor.run {
        closure()
    }
}

func delay(_ seconds: Double) async {
    try? await Task.sleep(for: .seconds(seconds))
}


