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
                .foregroundStyle(.black)
                .frame(width: 48, height: 48)
                .background(Color("LightBrown"))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(analogy.title)
                    .appFont(AppFont.headline)
                Text(analogy.description)
                    .appFont(AppFont.subheadline)
                    .foregroundStyle(Color("MediumBrown"))
            }
            
            Spacer()
        }
        .frame(minHeight: 72)
        .padding()
    }
}

#Preview {
    AnalogyRow(analogy: Analogy(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."))
}
