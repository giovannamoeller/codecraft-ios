//
//  AppFontModifier.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct AppFontModifier: ViewModifier {
    @Environment(\.appFont) var appFont
    
    func body(content: Content) -> some View {
        content.font(appFont)
    }
}
