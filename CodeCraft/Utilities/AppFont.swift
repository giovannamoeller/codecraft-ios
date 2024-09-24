//
//  FontManager.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

enum AppFont {
    static func plusJakartaSans(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .bold:
            return Font.custom("PlusJakartaSans-Bold", size: size)
        case .semibold:
            return Font.custom("PlusJakartaSans-SemiBold", size: size)
        case .medium:
            return Font.custom("PlusJakartaSans-Medium", size: size)
        default:
            return Font.custom("PlusJakartaSans-Regular", size: size)
        }
    }
    
    static let bodyRegular = plusJakartaSans(size: 16)
    static let bodyBold = plusJakartaSans(size: 16, weight: .bold)
    static let title = plusJakartaSans(size: 24, weight: .bold)
    static let headline = plusJakartaSans(size: 18, weight: .semibold)
}
