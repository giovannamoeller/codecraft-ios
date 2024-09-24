//
//  FontManager.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

func plusJakartaSans(size: CGFloat, weight: Font.Weight = .regular) -> Font {
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
