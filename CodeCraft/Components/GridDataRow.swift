//
//  AnalogyRow.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct GridDataRow: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let data: GridData
    
    var body: some View {
        HStack(spacing: 16.0) {
            Image(systemName: data.icon)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(AppTheme.Colors.indigo)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                ResponsiveTextView(text: data.title,
                                   style: .bodySemibold)
                
                ResponsiveTextView(text: data.description,
                                   style: .captionRegular,
                                   foregroundStyle: .secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12.0)
                .fill(AppTheme.Colors.lightLavender)
                //.frame(height: horizontalSizeClass == .regular ? 92.0 : .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 12.0)
                        .stroke(AppTheme.Colors.lightLavender, lineWidth: 2.0)
                }
        )
    }
}

#Preview {
    GridDataRow(data: GridData(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."))
}
