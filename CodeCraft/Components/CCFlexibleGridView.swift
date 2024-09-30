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
    
    let data: [GridData]
        
    var body: some View {
        layout {
            ForEach(data, id: \.id) { item in
                CCGridDataRow(data: item)
                    .frame(maxHeight: 420)
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
        GridData(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."),
        GridData(icon: "book", title: "Bookshelf", description: "Books arranged in order."),
        GridData(icon: "calendar", title: "Calendar", description: "Days of the month in sequence."),
        GridData(icon: "tram", title: "Train", description: "A series of connected carriages.")
    ])
}
