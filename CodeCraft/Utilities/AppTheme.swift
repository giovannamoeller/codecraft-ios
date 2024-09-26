//
//  AppTheme.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

enum AppTheme {
    enum Fonts {
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
        static let title3 = plusJakartaSans(size: 18, weight: .semibold)
        static let title = plusJakartaSans(size: 22, weight: .bold)
        static let largeTitle = plusJakartaSans(size: 28, weight: .bold)
        static let headline = plusJakartaSans(size: 16, weight: .semibold)
        static let subheadline = plusJakartaSans(size: 14)
    }
    
    enum Colors {
        static let lightBrown = Color("LightBrown")
        static let mediumBrown = Color("MediumBrown")
        static let darkGreen = Color("DarkGreen")
    }
}