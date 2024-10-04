//
//  DataStructureIntroductionView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

import SwiftUI

struct DataStructureIntroductionView<Destination: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let dataStructure: DataStructureInformation
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let destination: Destination
    
    init(dataStructure: DataStructureInformation, @ViewBuilder destination: @escaping () -> Destination) {
        self.dataStructure = dataStructure
        self.destination = destination()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 36.0) {
                /*Image(dataStructure.imageName)
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(height: 264)
                 .overlay(
                 LinearGradient(
                 gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                 startPoint: .top,
                 endPoint: .bottom
                 )
                 )*/
                
                VStack(alignment: .leading, spacing: 10) {
                    ResponsiveTextView(text: dataStructure.title.capitalizedFirst(), style: .title, foregroundStyle: AppTheme.Colors.indigo)
                    
                    ResponsiveTextView(text: dataStructure.definition, style: .bodyRegular)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    ResponsiveTextView(text: "Real world analogies", style: .subtitle)
                    
                    CCFlexibleGridView(data: dataStructure.analogies)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 3.0) {
                        ResponsiveTextView(text: "When to use", style: .subtitle)
                        ResponsiveTextView(text: dataStructure.title, style: .subtitle)
                    }
                    
                    ForEach(dataStructure.useCases, id: \.self) { useCase in
                        HStack {
                            Image(systemName: "square.and.pencil")
                            ResponsiveTextView(text: String(useCase), style: .bodyRegular)
                        }
                        .foregroundStyle(.black.opacity(0.75))
                    }
                }
                .padding(.horizontal)
                
                NavigationLink {
                    destination
                } label: {
                    CCPrimaryButtonView(text: "Learn More")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        //.ignoresSafeArea()
        .padding(.top, 32)
    }
}

#Preview {
    DataStructureIntroductionView(dataStructure: DataStructureInformation(
        title: "Array",
        imageName: "arrays-01",
        definition: "An array is a data structure that stores a collection of elements of the same type in contiguous memory locations. Each element in an array is identified by an index or a key.",
        analogies: [
            GridData(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."),
            GridData(icon: "book", title: "Bookshelf", description: "Books arranged in order."),
            GridData(icon: "calendar", title: "Calendar", description: "Days of the month in sequence."),
            GridData(icon: "tram", title: "Train", description: "A series of connected carriages.")
        ],
        useCases: [
            "When you need quick access to elements by index.",
            "For implementing other data structures like stacks and queues.",
            "When working with sequences of data (e.g., time series).",
            "In scenarios where memory locality is important for performance."
        ]
    ), destination: {
        InteractiveArrayView<Int>()
    })
}
