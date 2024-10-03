//
//  InteractiveBubbleSortView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let value: Int
    var position: CGFloat
}

enum SortStatus {
    case idle, sorting, stopped, sorted
}

struct InteractiveBubbleSortView: View {
    @State private var items: [Item] = generateRandomArray().enumerated().map { Item(value: $1, position: CGFloat($0)) }
    @State private var isButtonDisabled: Bool = false
    @State private var isSwapping: Bool = false
    @State private var outerIndex: Int = -1
    @State private var innerIndex: Int = -1
    @State private var sortStatus: SortStatus = .idle
    @State private var sortedIndices: Set<Int> = []
    @State private var selectedVelocity: SortVelocity = .normal
    
    private let baseSeconds: Double = 1.0
    private let itemSize: CGFloat = 64
    private let spacing: CGFloat = 16
    
    private var buttonText: String {
        switch sortStatus {
        case .idle:
            return "Start sorting"
        case .sorting:
            return "Sorting..."
        case .stopped:
            return "Sorting stopped"
        case .sorted:
            return "Sort again"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Visualize how the bubble sort algorithm works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: UsageExample.bubbleSort)
                    .padding()
                
                Text("Press 'start sorting' to see the algorithm in action.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                GeometryReader { geometry in
                    ZStack {
                        ForEach(items) { item in
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
                .frame(height: 200)  // Ajuste conforme necessário
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
                    Button(action: bubbleSort) {
                        CCSecondaryButtonView(text: buttonText,
                                              isDisabled: isButtonDisabled)
                    }
                    
                    if sortStatus == .stopped {
                        Button(action: resume) {
                            CCSecondaryButtonView(text: "Resume",
                                                  isDisabled: isButtonDisabled)
                        }
                    }
                }
                .padding(.top)
                .frame(maxWidth: 240)
                
                NavigationLink {
                    BubbleSortCodeCheatsheetView()
                } label: {
                    CCPrimaryButtonView(text: "Let's check the code")
                }
                .frame(maxWidth: 240)
                
            }
        }
    }
    
    private func getBackgroundColor(for index: Int) -> Color {
        switch index {
        case _ where sortedIndices.contains(index):
            return .green
        case outerIndex:
            return .yellow
        case innerIndex:
            return .mint
        default:
            return AppTheme.Colors.lightLavender
        }
    }
    
    private func bubbleSort() {
        disableButton()
        if sortStatus == .sorted { sortAgain() }
        sortStatus = .sorting
        sortedIndices.removeAll()
        
        let delayTime = baseSeconds / selectedVelocity.rawValue
        
        Task {
            for i in 0..<items.count {
                for j in 0..<items.count - i - 1 {
                    await MainActor.run {
                        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                            outerIndex = j
                            innerIndex = j + 1
                        }
                    }
                    try? await Task.sleep(for: .seconds(delayTime))
                    
                    if items[j].value > items[j + 1].value {
                        await MainActor.run {
                            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                                let tempPosition = items[j].position
                                items[j].position = items[j + 1].position
                                items[j + 1].position = tempPosition
                                items.swapAt(j, j + 1)
                            }
                        }
                        try? await Task.sleep(for: .seconds(delayTime))
                    }
                }
                await MainActor.run {
                    withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                        _ = sortedIndices.insert(items.count - i - 1)
                    }
                }
            }
            
            await MainActor.run {
                withAnimation(.easeInOut(duration: delayTime / 2)) {
                    sortStatus = .sorted
                    outerIndex = -1
                    innerIndex = -1
                }
            }
            enableButton()
        }
    }
    
    private func sortAgain() {
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            sortStatus = .sorting
            items = generateRandomArray().enumerated().map { Item(value: $1, position: CGFloat($0)) }
        }
    }
    
    private func resume() {
        
    }
    
    private func disableButton() {
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            isButtonDisabled = true
        }
    }
    
    private func enableButton() {
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            isButtonDisabled = false
        }
    }
}

#Preview {
    InteractiveBubbleSortView()
}
