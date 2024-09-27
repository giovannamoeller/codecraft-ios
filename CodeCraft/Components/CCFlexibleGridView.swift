//
//  CCFlexibleGridView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct CCFlexibleGridView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    let data: [Analogy]
    
    @State private var maxHeight: CGFloat = 420
    
    var body: some View {
        layout {
            ForEach(data, id: \.id) { item in
                CCAnalogyRow(analogy: item)
                    .frame(maxHeight: maxHeight) // Apply the max height here
            }
        }
    }
    
    @ViewBuilder
    private func layout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if horizontalSizeClass == .compact {
            VStack(spacing: 16) {
                content()
            }
        } else {
            LazyVGrid(columns: columns, spacing: 16) {
                content()
            }
        }
    }
}

#Preview {
    CCFlexibleGridView(data: [
        Analogy(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."),
        Analogy(icon: "book", title: "Bookshelf", description: "Books arranged in order."),
        Analogy(icon: "calendar", title: "Calendar", description: "Days of the month in sequence."),
        Analogy(icon: "tram", title: "Train", description: "A series of connected carriages.")
    ])
}
