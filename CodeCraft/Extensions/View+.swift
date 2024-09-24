//
//  View+.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

extension View {
    func withAppFont() -> some View {
        self.modifier(AppFontModifier())
    }
}
