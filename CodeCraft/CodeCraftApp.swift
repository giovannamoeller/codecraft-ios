//
//  CodeCraftApp.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

@main
struct CodeCraftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font, plusJakartaSans(size: 16))
        }
    }
}
