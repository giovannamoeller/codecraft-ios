//
//  AnalogyRow.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct CCAnalogyRow: View {
    let analogy: Analogy
    
    var body: some View {
        HStack(spacing: 16.0) {
            Image(systemName: analogy.icon)
                .foregroundStyle(.black)
                .frame(width: 48, height: 48)
                .background(AppTheme.Colors.lightBrown)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(analogy.title)
                    .appFont(AppTheme.Fonts.headline)
                Text(analogy.description)
                    .appFont(AppTheme.Fonts.subheadline)
                    .foregroundStyle(AppTheme.Colors.mediumBrown)
            }
            
            Spacer()
        }
        .frame(minHeight: 72)
        .padding()
    }
}

#Preview {
    CCAnalogyRow(analogy: Analogy(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."))
}
