//
//  InteractiveSortAlgorithmView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 03/10/24.
//

import SwiftUI

struct ArrayItem: Identifiable {
    let id = UUID()
    let value: Int
    var position: CGFloat
}

enum SortStatus {
    case idle, sorting, stopped, sorted
}

struct InteractiveGenericSortAlgorithmView<T: SortAlgorithmProtocol>: View {
    @State private var items: [ArrayItem] = generateRandomArray().enumerated().map { ArrayItem(value: $1, position: CGFloat($0)) }
    @State private var sortStatus: SortStatus = .idle
    @State private var currentStep: SortingStep?
    @State private var selectedVelocity: SortVelocity = .normal
    @State private var sortingTask: Task<Void, Never>?
    
    let algorithm: T
    let data: [GridData]
    
    private let itemSize: CGFloat = 64
    private let spacing: CGFloat = 16
    
    init(algorithm: T,
         data: [GridData]) {
        self.algorithm = algorithm
        self.data = data
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text(algorithm.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: data)
                    .padding()
                
                Text("Press 'start sorting' to see the algorithm in action.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                GeometryReader { geometry in
                    ZStack {
                        ForEach(currentStep?.items ?? items) { item in
                            Text("\(item.value)")
                                .appFont(AppTheme.Fonts.bodyBold)
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
                .frame(height: 200)
                .background(AppTheme.Colors.indigo)
                
                HStack {
                    Text("Speed:")
                        .appFont(AppTheme.Fonts.bodyRegular)
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
                    Button(action: startSorting) {
                        CCSecondaryButtonView(text: buttonText,
                                              isDisabled: sortStatus == .sorting)
                    }
                    
                    if sortStatus == .stopped {
                        Button(action: resumeSorting) {
                            CCSecondaryButtonView(text: "Resume",
                                                  isDisabled: false)
                        }
                    }
                }
                .padding(.top)
                .frame(maxWidth: 240)
                
                NavigationLink {
                    // CodeCheatsheetView(for: algorithm)
                } label: {
                    CCPrimaryButtonView(text: "Let's check the code")
                }
                .frame(maxWidth: 240)
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
