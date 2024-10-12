//
//  InteractiveSortAlgorithmView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import SwiftUI

enum SortStatus {
    case idle, sorting, stopped, sorted
}

struct InteractiveGenericSortAlgorithmView<T: SortAlgorithmProtocol>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var items: [ArrayItem] = generateRandomArray().enumerated().map { ArrayItem(value: $1, position: CGFloat($0)) }
    @State private var sortStatus: SortStatus = .idle
    @State private var currentStep: SortingStep?
    @State private var selectedVelocity: SortVelocity = .normal
    @State private var sortingTask: Task<Void, Never>?
    
    let algorithm: T
    let data: [GridData]
    
    private var itemSize: CGFloat {
        return horizontalSizeClass == .compact ? 54.0 : 64.0
    }
    private var spacing: CGFloat {
        return horizontalSizeClass == .compact ? 8.0 : 16.0
    }
    
    init(algorithm: T,
         data: [GridData]) {
        self.algorithm = algorithm
        self.data = data
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                InteractiveHeaderView(text: algorithm.description, data: data, guideline: "Press 'start sorting' to see the algorithm in action.")
                
                GeometryReader { geometry in
                    ZStack {
                        ForEach(currentStep?.items ?? items) { item in
                            ResponsiveTextView(text: "\(item.value)", style: .bodyBold, alignment: .center)
                                .padding()
                                .frame(width: itemSize, height: itemSize)
                                .background(getBackgroundColor(for: Int(item.position)))
                                .cornerRadius(12.0)
                                .position(
                                    x: geometry.size.width / 2 + (item.position - CGFloat(items.count - 1) / 2) * (itemSize + spacing),
                                    y: geometry.size.height / 2
                                )
                                .animation(.spring(), value: item.position)
                        }
                    }
                }
                .frame(height: 164)
                .background(AppTheme.Colors.indigo)
                
                HStack {
                    ResponsiveTextView(text: "Speed", style: .bodyRegular, alignment: .trailing)
                    Picker("Velocity", selection: $selectedVelocity) {
                        ForEach(SortVelocity.allCases) { velocity in
                            Text(velocity.description)
                                .font(AppTheme.Fonts.bodyRegular)
                                .tag(velocity)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .disabled(sortStatus == .sorting)
                }
                .padding(8)
                
                HStack {
                    SecondaryButtonView(text: buttonText, isDisabled: sortStatus == .sorting) {
                        startSorting()
                    }
                    if sortStatus == .stopped {
                        SecondaryButtonView(text: "Resume") {
                            resumeSorting()
                        }
                    }
                }
                .padding(.top)
                .frame(maxWidth: 240)
                
                NavigationLink {
                    // CodeCheatsheetView(for: algorithm)
                } label: {
                    PrimaryButtonView(text: "Let's check the code")
                }
                .frame(maxWidth: 280)
            }
        }
    }
    
    private var buttonText: String {
        switch sortStatus {
        case .idle: return "Start sorting"
        case .sorting: return "Sorting..."
        case .stopped: return "Sorting stopped"
        case .sorted: return "Sort again"
        }
    }
    
    private func getBackgroundColor(for index: Int) -> Color {
        switch index {
        case _ where currentStep?.sortedIndices.contains(index) == true:
            return .green
        case currentStep?.currentIndex:
            return .yellow
        case currentStep?.comparingIndex:
            return .mint
        default:
            return AppTheme.Colors.lightLavender
        }
    }
    
    private func startSorting() {
        if sortStatus == .sorted {
            items = generateRandomArray().enumerated().map { ArrayItem(value: $1, position: CGFloat($0)) }
            currentStep = nil
        }
        sortStatus = .sorting
        sortingTask = Task {
            for await step in await algorithm.sort(items: items) {
                await MainActor.run {
                    withAnimation {
                        currentStep = step
                    }
                }
                try? await Task.sleep(for: .seconds(1 / selectedVelocity.rawValue))
                if Task.isCancelled { break }
            }
            await MainActor.run {
                sortStatus = .sorted
            }
        }
    }
    
    private func resumeSorting() {
        sortStatus = .sorting
        // Implementation depends on how you want to handle resuming
    }
}

#Preview {
    InteractiveGenericSortAlgorithmView<BubbleSort>(algorithm: BubbleSort(),
                                                    data: UsageExample.bubbleSort)
}
