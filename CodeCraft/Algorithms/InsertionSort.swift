//
//  InsertionSort.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import Foundation

struct InsertionSort: SortAlgorithmProtocol {
    let name = "Insertion Sort"
    let description = "Visualize how the insertion sort algorithm works"
    
    func sort(items: [ArrayItem]) async -> AsyncStream<SortingStep> {
        return AsyncStream { continuation in
            Task {
                var mutableItems = items
                var sortedIndices = Set<Int>()
                
                for i in 1..<mutableItems.count {
                    var j = i
                    while j > 0 && mutableItems[j].value < mutableItems[j - 1].value {
                        continuation.yield(SortingStep(items: mutableItems, currentIndex: j, comparingIndex: j - 1, sortedIndices: sortedIndices))
                        try? await Task.sleep(for: .milliseconds(500))
                        
                        mutableItems.swapAt(j, j - 1)
                        mutableItems[j].position = CGFloat(j)
                        mutableItems[j - 1].position = CGFloat(j - 1)
                        j -= 1
                    }
                    sortedIndices = Set(0...i)
                }
                
                continuation.yield(SortingStep(items: mutableItems, currentIndex: -1, comparingIndex: -1, sortedIndices: sortedIndices))
                continuation.finish()
            }
        }
    }
}
