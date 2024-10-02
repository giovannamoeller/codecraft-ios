//
//  Utils.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 30/09/24.
//

import SwiftUI

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

@MainActor
func updateOnMainThreadWithCustomAnimation<T>(animation: Animation = .easeInOut(duration: 0.3), _ body: @escaping () -> T) async -> T {
    withAnimation(animation) {
        body()
    }
}

@MainActor
func updateOnMainThreadWithDefaultAnimation<T>(_ animationDuration: Double = 0.5, _ body: @escaping () -> T) async -> T {
    withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
        body()
    }
}

@MainActor
func updateOnMainThread<T>(_ body: @escaping () -> T) async -> T {
    body()
}

func delay(_ seconds: Double) async {
    try? await Task.sleep(for: .seconds(seconds))
}


