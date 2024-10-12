//
//  ResponsiveFontStyle.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import Foundation

struct ResponsiveFontStyle {
    let compact: FontStyle
    let regular: FontStyle
    
    static let extraLargeTitle = ResponsiveFontStyle(compact: .largeTitle, regular: .extraLargeTitle)
    static let title = ResponsiveFontStyle(compact: .title, regular: .largeTitle)
    static let subtitle = ResponsiveFontStyle(compact: .title3, regular: .title2)
    static let bodyRegular = ResponsiveFontStyle(compact: .captionRegular, regular: .bodyRegular)
    static let bodySemibold = ResponsiveFontStyle(compact: .captionSemibold, regular: .bodySemibold)
    static let bodyBold = ResponsiveFontStyle(compact: .captionBold, regular: .bodyBold)
    static let captionRegular = ResponsiveFontStyle(compact: .footnoteRegular, regular: .captionRegular)
    static let captionSemibold = ResponsiveFontStyle(compact: .footnoteSemibold, regular: .captionSemibold)
    static let captionBold = ResponsiveFontStyle(compact: .footnotBold, regular: .bodyBold)
    
}
