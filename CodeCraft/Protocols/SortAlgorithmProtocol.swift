//
//  SortAlgorithmProtocol.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import SwiftUI

protocol SortAlgorithmProtocol {
    func sort(items: [ArrayItem]) async -> AsyncStream<SortingStep>
    var name: String { get }
    var description: String { get }
}
