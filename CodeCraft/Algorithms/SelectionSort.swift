//
//  SelectionSort.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct SelectionSort: SortAlgorithmProtocol {
    let name: String = "Selection Sort"
    let description: String = "Visualize how the selection sort algorithm works"
    
    func sort(items: [ArrayItem]) async -> AsyncStream<SortingStep> {
        return AsyncStream { continuation in
            Task {
                var mutableItems = items
                var sortedIndices = Set<Int>()
                
                for i in 0..<mutableItems.count {
                    var minIndex = i
                    
                    for j in i + 1..<mutableItems.count {
                        continuation.yield(SortingStep(items: mutableItems, currentIndex: i, comparingIndex: j, sortedIndices: sortedIndices))
                        try? await Task.sleep(for: .milliseconds(500))
                        
                        if mutableItems[j].value < mutableItems[minIndex].value {
                            minIndex = j
                        }
                    }
                    
                    if i != minIndex {
                        mutableItems.swapAt(i, minIndex)
                        mutableItems[i].position = CGFloat(i)
                        mutableItems[minIndex].position = CGFloat(minIndex)
                        
                        continuation.yield(SortingStep(items: mutableItems, currentIndex: i, comparingIndex: minIndex, sortedIndices: sortedIndices))
                        try? await Task.sleep(for: .milliseconds(500))
                    }
                    
                    sortedIndices.insert(i)
                }
                
                continuation.yield(SortingStep(items: mutableItems, currentIndex: -1, comparingIndex: -1, sortedIndices: sortedIndices))
                continuation.finish()
            }
        }
    }
}
