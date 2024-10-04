//
//  InteractiveInsertionSortView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import SwiftUI

struct InteractiveInsertionSortView: View {
    var body: some View {
        InteractiveGenericSortAlgorithmView(algorithm: InsertionSort(), data: UsageExample.insertionSort)
    }
}

#Preview {
    InteractiveInsertionSortView()
}
