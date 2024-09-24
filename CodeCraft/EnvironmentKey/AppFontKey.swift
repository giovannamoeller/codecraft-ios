//
//  AppFontKey.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct AppFontKey: EnvironmentKey {
    static let defaultValue: Font = .system(size: 16)
}

extension EnvironmentValues {
    var appFont: Font {
        get { self[AppFontKey.self] }
        set { self[AppFontKey.self] = newValue }
    }
}
