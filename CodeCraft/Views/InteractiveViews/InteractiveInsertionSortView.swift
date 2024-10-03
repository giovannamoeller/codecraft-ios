//
//  InteractiveInsertionSortView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import SwiftUI

struct InteractiveInsertionSortView: View {
    @State private var items: [Item] = generateRandomArray().enumerated().map { Item(value: $1, position: CGFloat($0)) }
    @State private var isButtonDisabled: Bool = false
    @State private var isInserting: Bool = false
    @State private var currentIndex: Int = -1
    @State private var comparingIndex: Int = -1
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
                Text("Visualize how the insertion sort algorithm works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: UsageExample.insertionSort)
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
                    Button(action: insertionSort) {
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
                    //InsertionSortCodeCheatsheetView()
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
        case currentIndex:
            return .yellow
        case comparingIndex:
            return .mint
        default:
            return AppTheme.Colors.lightLavender
        }
    }
    
    private func insertionSort() {
        disableButton()
        if sortStatus == .sorted { sortAgain() }
        sortStatus = .sorting
        sortedIndices.removeAll()
        
        let delayTime = baseSeconds / selectedVelocity.rawValue
        
        Task {
            for i in 1..<items.count {
                var j = i
                
                await MainActor.run {
                    withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                        currentIndex = i
                        comparingIndex = j - 1
                    }
                }
                try? await Task.sleep(for: .seconds(delayTime))
                
                while j > 0 && items[j].value < items[j - 1].value {
                    await MainActor.run {
                        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                            items.swapAt(j, j - 1)
                            items[j].position = CGFloat(j)
                            items[j - 1].position = CGFloat(j - 1)
                        }
                    }
                    try? await Task.sleep(for: .seconds(delayTime))
                    await MainActor.run {
                        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                            j -= 1
                            currentIndex = j
                            comparingIndex = j - 1
                        }
                    }
                    try? await Task.sleep(for: .seconds(delayTime))
                }
                
                /*await MainActor.run {
                    withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                        for k in 0...i {
                            sortedIndices.insert(k)
                        }
                    }
                }
                
                try? await Task.sleep(for: .seconds(delayTime))*/
            }
            
            await MainActor.run {
                withAnimation(.easeInOut(duration: delayTime / 2)) {
                    sortStatus = .sorted
                    currentIndex = -1
                    sortedIndices = Set(0..<items.count)
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
        // Implementar a lógica de retomada aqui
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
    InteractiveInsertionSortView()
}
