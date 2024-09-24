//
//  AnalogyRow.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct AnalogyRow: View {
    let analogy: Analogy
    
    var body: some View {
        HStack(spacing: 16.0) {
            Image(systemName: analogy.icon)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(analogy.title)
                    .appFont(AppFont.headline)
                Text(analogy.description)
                    .appFont(AppFont.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .frame(minHeight: 72)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    AnalogyRow(analogy: Analogy(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."))
}
