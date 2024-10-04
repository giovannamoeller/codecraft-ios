//
//  FontStyle.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

enum FontStyle {
    case extraLargeTitle
    case largeTitle
    case title
    case title2
    case title3
    case bodyRegular
    case bodyBold
    case bodySemibold
    case captionRegular
    case captionSemibold
    case captionBold
    case footnoteRegular
    case footnoteSemibold
    case footnotBold
    
    var font: Font {
        switch self {
        case .extraLargeTitle: return AppTheme.Fonts.extraLargeTitle
        case .largeTitle: return AppTheme.Fonts.largeTitle
        case .title: return AppTheme.Fonts.title
        case .title2: return AppTheme.Fonts.title2
        case .title3: return AppTheme.Fonts.title3
        case .bodyRegular: return AppTheme.Fonts.bodyRegular
        case .bodyBold: return AppTheme.Fonts.bodyBold
        case .bodySemibold: return AppTheme.Fonts.bodySemibold
        case .captionRegular: return AppTheme.Fonts.captionRegular
        case .captionSemibold: return AppTheme.Fonts.captionSemibold
        case .captionBold: return AppTheme.Fonts.captionBold
        case .footnoteRegular: return AppTheme.Fonts.footnoteRegular
        case .footnoteSemibold: return AppTheme.Fonts.footnoteSemibold
        case .footnotBold: return AppTheme.Fonts.footnoteBold
        }
    }
}
