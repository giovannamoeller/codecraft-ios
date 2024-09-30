//
//  AnalogyRow.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct CCGridDataRow: View {
    let data: GridData
    
    var body: some View {
        HStack(spacing: 16.0) {
            Image(systemName: data.icon)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(AppTheme.Colors.indigo)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(data.title)
                    .appFont(AppTheme.Fonts.headline)
                Text(data.description)
                    .appFont(AppTheme.Fonts.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12.0)
                .fill(AppTheme.Colors.lightLavender)
                .frame(height: 88.0)
                .overlay {
                    RoundedRectangle(cornerRadius: 12.0)
                        .stroke(AppTheme.Colors.lightLavender, lineWidth: 2.0)
                }
        )
    }
}

#Preview {
    CCGridDataRow(data: GridData(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."))
}
