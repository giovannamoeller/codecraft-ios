//
//  Analogy.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct Analogy: Identifiable {
    let id = UUID()
    let icon: String
    let title: LocalizedStringKey
    let description: LocalizedStringKey
}
