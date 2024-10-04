//
//  BubbleSort.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import SwiftUI

struct BubbleSort: SortAlgorithmProtocol {
    let name: String = "Bubble Sort"
    let description: String = "Visualize how the bubble sort algorithm works"
    
    func sort(items: [ArrayItem]) async -> AsyncStream<SortingStep> {
        return AsyncStream { continuation in
            Task {
                var mutableItems = items
                var sortedIndices = Set<Int>()
                
                for i in 0..<mutableItems.count {
                    for j in 0..<mutableItems.count - i - 1 {
                        continuation.yield(SortingStep(items: mutableItems, currentIndex: j, comparingIndex: j + 1, sortedIndices: sortedIndices))
                        await delay(2)
                        
                        if mutableItems[j].value > mutableItems[j + 1].value {
                            mutableItems.swapAt(j, j + 1)
                            let tempPosition = mutableItems[j].position
                            mutableItems[j].position = mutableItems[j + 1].position
                            mutableItems[j + 1].position = tempPosition
                            
                            continuation.yield(SortingStep(items: mutableItems, currentIndex: j, comparingIndex: j + 1, sortedIndices: sortedIndices))
                            await delay(2)
                        }
                    }
                    sortedIndices.insert(mutableItems.count - i - 1)
                }
                
                continuation.yield(SortingStep(items: mutableItems, currentIndex: -1, comparingIndex: -1, sortedIndices: sortedIndices))
                continuation.finish()
            }
        }
    }
}
