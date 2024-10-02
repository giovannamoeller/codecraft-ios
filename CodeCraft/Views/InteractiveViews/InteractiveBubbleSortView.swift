//
//  InteractiveBubbleSortView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import SwiftUI

enum SortStatus {
    case idle, sorting, stopped, sorted
}

struct InteractiveBubbleSortView: View {
    @State private var array: [Int] = [37, 48, 23, 49, 12, 7]
    @State private var isButtonDisabled: Bool = false
    @State private var isSwapping: Bool = false
    @State private var outerIndex: Int = -1
    @State private var innerIndex: Int = -1
    @State private var sortStatus: SortStatus = .idle
    @State private var sortedIndices: Set<Int> = []
    @State private var selectedVelocity: SortVelocity = .normal
    
    private let baseSeconds: Double = 0.5
    
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
                .padding()
                
                HStack(spacing: 16) {
                    ForEach(0..<array.count, id: \.self) { index in
                        Text("\(array[index])")
                            .appFont(AppTheme.Fonts.bodyBold)
                            .padding()
                            .frame(width: 64, height: 64)
                            .background(getBackgroundColor(for: index))
                            .cornerRadius(12.0)
                            .offset(y: (index == outerIndex || index == innerIndex) && isSwapping ? -40 : 0)
                    }
                    .animation(.spring(), value: isSwapping)
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 248)
                .background(AppTheme.Colors.indigo)
                
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
                    //
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
            for i in 0..<array.count {
                for j in 0..<array.count - i - 1 {
                    await MainActor.run {
                        withAnimation(.easeInOut(duration: delayTime)) {
                            outerIndex = j
                            innerIndex = j + 1
                        }
                    }
                    try? await Task.sleep(for: .seconds(delayTime))
                    
                    if array[j] > array[j + 1] {
                        await MainActor.run {
                            withAnimation(.easeInOut(duration: delayTime)) {
                                isSwapping = true
                            }
                        }
                        try? await Task.sleep(for: .seconds(delayTime))
                        
                        await MainActor.run {
                            withAnimation(.easeInOut(duration: delayTime)) {
                                array.swapAt(j, j + 1)
                            }
                        }
                        try? await Task.sleep(for: .seconds(delayTime))
                        
                        await MainActor.run {
                            withAnimation(.easeInOut(duration: delayTime)) {
                                isSwapping = false
                            }
                        }
                        try? await Task.sleep(for: .seconds(delayTime))
                    }
                }
                await MainActor.run {
                    withAnimation(.easeInOut(duration: delayTime)) {
                        _ = sortedIndices.insert(array.count - i - 1)
                    }
                }
            }
            
            await MainActor.run {
                withAnimation(.easeInOut(duration: delayTime)) {
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
            array = [37, 48, 23, 49, 12, 7]
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
