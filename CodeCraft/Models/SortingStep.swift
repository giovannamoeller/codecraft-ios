//
//  SortingStep.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import Foundation

struct SortingStep {
    let items: [ArrayItem]
    let currentIndex: Int
    let comparingIndex: Int
    let sortedIndices: Set<Int>
}
