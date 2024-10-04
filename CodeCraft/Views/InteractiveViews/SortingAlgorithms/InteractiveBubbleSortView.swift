//
//  InteractiveBubbleSortView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import SwiftUI

struct InteractiveBubbleSortView: View {
    var body: some View {
        InteractiveGenericSortAlgorithmView(algorithm: BubbleSort(), data: UsageExample.bubbleSort)
    }
}

#Preview {
    InteractiveBubbleSortView()
}
