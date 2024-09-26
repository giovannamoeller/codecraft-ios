//
//  ArrayIntroductionView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct ArrayIntroductionView: View {
    
    let arrayInformations = DataStructureInformation(
        title: "arrays",
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
    )
    
    var body: some View {
        DataStructureIntroductionView(dataStructure: arrayInformations) {
            InteractiveArrayView()
        }
    }
}

#Preview {
    ArrayIntroductionView()
}
