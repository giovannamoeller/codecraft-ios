//
//  InteractiveLinearSearchView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 07/10/24.
//

import SwiftUI

enum SearchStatus {
    case idle, searching, stopped, searched
}

struct InteractiveLinearSearchView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var items: [ArrayItem] = generateRandomArray(8).enumerated().map { ArrayItem(value: $1, position: CGFloat($0)) }
    @State private var searchStatus: SearchStatus = .idle
    @State private var elementToFind: String = ""
    @State private var foundIndex: ArrayItem?
    @State private var comparingIndex: ArrayItem?
    @State private var offsetY: CGFloat = 0
    
    private var isTextFieldValid: Bool {
        let trimmedInput = elementToFind.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else { return false }
        return Int(trimmedInput) != nil
    }
    
    private var itemSize: CGFloat {
        return horizontalSizeClass == .compact ? 54.0 : 64.0
    }
    
    private var buttonText: String {
        switch searchStatus {
        case .idle: return "Start searching"
        case .searching: return "Searching..."
        case .stopped: return "Searching stopped"
        case .searched: return "Search again"
        }
    }
    
    var body: some View {
        ZStack {
            if let _ = foundIndex {
                ConfettiLottieView()
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16.0) {
                    InteractiveHeaderView(text: "Visualize how linear search works", data: UsageExample.linearSearch, guideline: "Press 'start searching' to see the algorithm in action.")
                    
                    VStack {
                        ResponsiveTextView(text: "Enter the element to find in the array:", style: .bodyBold, alignment: .center)
                        HStack {
                            NeumorphicStyleTextField(textField: TextField("Example: 18", text: $elementToFind), imageName: "magnifyingglass")
                        }
                    }
                    .padding()
                    .frame(maxWidth: 420.0)
                    
                    if let foundIndex {
                        ResponsiveTextView(text: "Element found on index \(Int(foundIndex.position))!", style: .bodyRegular, alignment: .center)
                            .padding()
                            .transition(.scale.combined(with: .opacity))
                    } else if foundIndex == nil && searchStatus == .searched {
                        ResponsiveTextView(text: "The element \(Int(elementToFind)) was not found in the array!", style: .bodyRegular)
                    }
                    
                    HStack(spacing: 8.0) {
                        ForEach(items) { item in
                            ResponsiveTextView(text: "\(item.value)", style: .bodyBold, alignment: .center)
                                .padding()
                                .frame(width: itemSize, height: itemSize)
                                .background(getBackgroundColor(for: item.id))
                                .foregroundStyle(.black)
                                .cornerRadius(12.0)
                                .scaleEffect(comparingIndex?.id == item.id ? 1.1 : (foundIndex?.id == item.id ? 1.2 : 1.0))
                                .offset(y: foundIndex?.id == item.id ? offsetY : 0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3), value: comparingIndex?.id)
                                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3), value: foundIndex?.id)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12.0)
                                        .stroke(getStrokeColor(for: item.id), lineWidth: getStrokeWidth(for: item.id))
                                        .scaleEffect(comparingIndex?.id == item.id ? 1.1 : (foundIndex?.id == item.id ? 1.1 : 1.0))
                                )
                                .zIndex(getZIndex(for: item.id))
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        SecondaryButtonView(text: buttonText,
                                            isDisabled: searchStatus == .searching || !isTextFieldValid) {
                            linearSearch()
                        }
                        
                        SecondaryButtonView(text: "Shuffle Array",
                                            isDisabled: searchStatus == .searching) {
                            shuffleArray()
                        }
                    }
                    .padding(.top)
                    .frame(maxWidth: 420)
                    
                    NavigationLink {
                        //CodeCheatsheetView(for: algorithm)
                    } label: {
                        PrimaryButtonView(text: "Let's check the code")
                    }
                    .frame(maxWidth: 280)
                }
                .padding()
            }
            .animation(.easeInOut, value: foundIndex)
            .onChange(of: foundIndex, { _, _ in
                if foundIndex != nil {
                    withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                        offsetY = -20
                    }
                } else {
                    offsetY = 0
                }
            })
        }
    }
    
    private func getBackgroundColor(for id: UUID) -> Color {
        if foundIndex?.id == id {
            return .green
        } else if comparingIndex?.id == id {
            return .yellow
        }
        return AppTheme.Colors.lightLavender
    }
    
    private func getStrokeColor(for id: UUID) -> Color {
        if comparingIndex?.id == id {
            return AppTheme.Colors.indigo
        }
        return .clear
    }
    
    private func getStrokeWidth(for id: UUID) -> CGFloat {
        if comparingIndex?.id == id {
            return 2
        }
        return 0
    }
    
    private func getZIndex(for id: UUID) -> Double {
        if foundIndex?.id == id {
            return 2
        } else if comparingIndex?.id == id {
            return 1
        }
        return 0
    }
    
    private func shuffleArray() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3)) {
            items.shuffle()
            for (index, _) in items.enumerated() {
                items[index].position = CGFloat(index)
            }
            searchStatus = .idle
            comparingIndex = nil
            elementToFind = ""
        }
    }
    
    private func linearSearch() {
        changeButtonStatus(to: .searching)
        guard let element = Int(elementToFind) else { return }
        Task {
            for i in 0..<items.count {
                await updateOnMainThread {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3)) {
                        comparingIndex = items[i]
                    }
                }
                await delay(1.0)
                if items[i].value == element {
                    await delay(0.5)
                    await updateOnMainThread {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                            foundIndex = items[i]
                            comparingIndex = nil
                        }
                    }
                    break
                }
            }
            await delay(0.5)
            await updateOnMainThread {
                reset()
            }
        }
    }
    
    private func reset() {
        withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
            comparingIndex = nil
            searchStatus = .searched
            elementToFind = ""
        }
    }
    
    private func changeButtonStatus(to status: SearchStatus) {
        withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
            searchStatus = status
            foundIndex = nil
        }
    }
}

#Preview {
    InteractiveLinearSearchView()
}
