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
        
        static let extraLargeTitle = plusJakartaSans(size: 54, weight: .bold)
        static let largeTitle = plusJakartaSans(size: 28, weight: .bold)
        static let title = plusJakartaSans(size: 22, weight: .bold)
        static let title2 = plusJakartaSans(size: 20, weight: .bold)
        static let title3 = plusJakartaSans(size: 18, weight: .bold)
        static let bodyRegular = plusJakartaSans(size: 18)
        static let bodyBold = plusJakartaSans(size: 18, weight: .bold)
        static let bodySemibold = plusJakartaSans(size: 18, weight: .semibold)
        static let captionRegular = plusJakartaSans(size: 14)
        static let captionBold = plusJakartaSans(size: 14, weight: .bold)
        static let captionSemibold = plusJakartaSans(size: 14, weight: .semibold)
        static let footnoteRegular = plusJakartaSans(size: 12)
        static let footnoteBold = plusJakartaSans(size: 12, weight: .bold)
        static let footnoteSemibold = plusJakartaSans(size: 12, weight: .semibold)
    }
    
    enum Colors {
        static let lightLavender = Color("LightLavender")
        static let mediumLavender = Color("MediumLavender")
        static let indigo = Color("Indigo")
        static let eletricBlue = Color("EletricBlue")
        static let darkGray = Color("DarkGray")
        
        static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
        static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
        static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
        static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
    }
}
