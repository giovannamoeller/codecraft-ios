//
//  InteractiveSelectionSortView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct InteractiveSelectionSortView: View {
    var body: some View {
        InteractiveGenericSortAlgorithmView(algorithm: SelectionSort(), data: UsageExample.selectionSort)
    }
}

#Preview {
    InteractiveSelectionSortView()
}
