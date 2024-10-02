//
//  SortVelocity.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import Foundation

enum SortVelocity: Double, CaseIterable, Identifiable {
    case slow = 0.5
    case mediumSlow = 0.75
    case normal = 1.0
    case mediumFast = 1.25
    case fast = 1.5
    case veryFast = 1.75
    case ultraFast = 2.0
    
    var id: Double { self.rawValue }
    
    var description: String {
        switch self {
        case .slow: return "0.5x"
        case .mediumSlow: return "0.75x"
        case .normal: return "1x"
        case .mediumFast: return "1.25x"
        case .fast: return "1.5x"
        case .veryFast: return "1.75x"
        case .ultraFast: return "2.0x"
        }
    }
}
