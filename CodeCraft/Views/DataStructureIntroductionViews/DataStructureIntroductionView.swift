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
                    Text(dataStructure.title.capitalizedFirst())
                        .appFont(AppTheme.Fonts.title)
                    
                    Text(dataStructure.definition)
                        .appFont(AppTheme.Fonts.bodyRegular)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Real world analogies")
                        .appFont(AppTheme.Fonts.title)
                    
                    if horizontalSizeClass == .compact {
                        ForEach(dataStructure.analogies) { analogy in
                            AnalogyRow(analogy: analogy)
                        }
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(dataStructure.analogies) { analogy in
                                AnalogyRow(analogy: analogy)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(AppTheme.Colors.lightBrown, lineWidth: 2.0)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 3.0) {
                        Text("When to use")
                        Text(dataStructure.title)
                    }
                    .appFont(AppTheme.Fonts.title)
                    
                    
                    ForEach(dataStructure.useCases, id: \.self) { useCase in
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text(LocalizedStringKey(useCase))
                                .appFont(AppTheme.Fonts.bodyRegular)
                        }
                        .foregroundStyle(.black.opacity(0.75))
                    }
                }
                .padding(.horizontal)
                
                NavigationLink {
                    destination
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                        Text("Learn More")
                            .appFont(AppTheme.Fonts.bodyBold)
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(AppTheme.Colors.darkGreen)
                    .cornerRadius(24.0)
                    .frame(maxWidth: .infinity)
                    .padding()
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
            Analogy(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."),
            Analogy(icon: "book", title: "Bookshelf", description: "Books arranged in order."),
            Analogy(icon: "calendar", title: "Calendar", description: "Days of the month in sequence."),
            Analogy(icon: "tram", title: "Train", description: "A series of connected carriages.")
        ],
        useCases: [
            "When you need quick access to elements by index.",
            "For implementing other data structures like stacks and queues.",
            "When working with sequences of data (e.g., time series).",
            "In scenarios where memory locality is important for performance."
        ]
    ), destination: {
        InteractiveArrayView()
    })
}
