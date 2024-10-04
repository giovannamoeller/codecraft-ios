//
//  FlexibleGridView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct FlexibleGridView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    let data: [GridData]
        
    var body: some View {
        layout {
            ForEach(data, id: \.id) { item in
                GridDataRow(data: item)
                    .padding(.bottom, horizontalSizeClass == .compact ? 8.0 : 0.0)
            }
        }
    }
    
    @ViewBuilder
    private func layout<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if horizontalSizeClass == .compact {
            VStack(spacing: 8.0) {
                content()
            }
        } else {
            LazyVGrid(columns: columns, spacing: 8.0) {
                content()
            }
        }
    }
}

#Preview {
    FlexibleGridView(data: [
        GridData(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."),
        GridData(icon: "book", title: "Bookshelf", description: "Books arranged in order."),
        GridData(icon: "calendar", title: "Calendar", description: "Days of the month in sequence."),
        GridData(icon: "tram", title: "Train", description: "A series of connected carriages.")
    ])
}
