//
//  DataStructureIntroductionView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

import SwiftUI

struct DataStructureIntroductionView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let dataStructure: DataStructureInformation
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
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
                    Text("What is a \(dataStructure.title)?")
                        .appFont(AppFont.title)
                    
                    Text(dataStructure.definition)
                        .appFont(AppFont.bodyRegular)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Real-World Analogies")
                        .appFont(AppFont.title)
                    
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
                                            .stroke(Color("LightBrown"), lineWidth: 2.0)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("When to use \(dataStructure.title)")
                        .appFont(AppFont.title)
                    
                    ForEach(dataStructure.useCases, id: \.self) { useCase in
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text(useCase)
                                .appFont(AppFont.bodyRegular)
                        }
                        .foregroundStyle(.black.opacity(0.75))
                    }
                }
                .padding(.horizontal)
                
                Button {
                    // Action
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                        Text("Learn more")
                            .appFont(AppFont.bodyBold)
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color("DarkGreen"))
                    .cornerRadius(24.0)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
        }
        //.ignoresSafeArea()
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
    ))
}