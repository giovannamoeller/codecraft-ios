//
//  InteractiveArrayView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

enum ArrayAction {
    case none, push, pop
}

struct InteractiveArrayView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var newElementValue: String = ""
    @State private var insertIndex: String = ""
    @State private var isInserting: Bool = false
    @State private var isRemoving: Bool = false
    @State private var removingIndex: Int?
    @State private var showInstructions = false
    @State private var lastAction: ArrayAction = .none
    @State private var offset: CGFloat = 0
    @State private var showIndexOffBounds: Bool = false
    
    let analogies: [Analogy] = [
        Analogy(icon: "info.circle", title: "Zero-indexed", description: "Arrays are zero-indexed: The first element is at index 0."),
        Analogy(icon: "info.circle", title: "Unique index", description: "Each element has a unique index: Used to access or modify the element."),
        Analogy(icon: "info.circle", title: "Fixed and Dynamic", description: "Arrays have a fixed size in some languages, but can be dynamic in others."),
        Analogy(icon: "info.circle", title: "Common operations", description: "Common operations: Insertion, deletion, and accessing elements."),
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    private func getRandomElement() -> Int {
        return Int.random(in: 0..<100)
    }
    
    @StateObject private var array = CCDynamicArray<Int>(count: 5) {
        Int.random(in: 0..<100)
    }
    
    private func pushElement() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            isInserting = true
            lastAction = .push
            array.insertAtLastPosition(getRandomElement())
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.spring()) {
                isInserting = false
                lastAction = .none
            }
        }
    }
    
    private func removeElement(at index: Int) {
        guard index >= 0 && index < array.count else {
            withAnimation {
                showIndexOffBounds = true
            }
            return
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            isRemoving = true
            removingIndex = index
            lastAction = .pop
            offset = 60 // Shift the array to the right
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let _ = array.removeAtLastPosition()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                isRemoving = false
                removingIndex = nil
                lastAction = .none
                offset = 0 // Smoothly animate back to center
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 16.0) {
                    Text("Visualize how an array works")
                        .appFont(AppTheme.Fonts.largeTitle)
                        .padding()
                    
                    // Informations
                    
                    if horizontalSizeClass == .compact {
                        ForEach(analogies, id: \.id) { analogy in
                            AnalogyRow(analogy: analogy)
                        }
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(analogies, id: \.id) { analogy in
                                AnalogyRow(analogy: analogy)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(AppTheme.Colors.lightBrown, lineWidth: 2.0)
                                    }
                            }
                        }
                    }
                    
                    // Visualization
                    
                    Text("Observe how the array changes as you perform operations below.")
                        .appFont(AppTheme.Fonts.bodyRegular)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8.0) {
                            ForEach(Array(array.elements.enumerated()), id: \.0) { index, element in
                                
                                VStack(spacing: 4.0) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(AppTheme.Colors.lightBrown)
                                            .frame(width: 60, height: 60)
                                        Text("\(element)")
                                            .appFont(AppTheme.Fonts.title3)
                                    }
                                    Text("\(index)")
                                        .appFont(AppTheme.Fonts.bodyRegular)
                                        .foregroundStyle(AppTheme.Colors.darkGreen)
                                }
                                .opacity(isRemoving && removingIndex == index ? 0 : 1)
                                .scaleEffect(lastAction == .push && index == array.count - 1 ? 0.5 : 1)
                                .offset(x: lastAction == .push && index == array.count - 1 ? 70 : 0)
                                .offset(y: lastAction == .pop && index == array.count - 1 ? 50 : 0)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 32)
                        .padding()
                        .offset(x: offset)
                    }
                    .padding(.vertical, 32)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3), value: array.count)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3), value: offset)
                    
                    // Controls view
                    VStack(spacing: 15) {
                        HStack {
                            Button {
                                pushElement()
                            } label: {
                                Text("Push")
                            }
                            .frame(minWidth: 88)
                            .padding()
                            .background(AppTheme.Colors.darkGreen)
                            .foregroundStyle(.white)
                            .appFont(AppTheme.Fonts.title3)
                            .cornerRadius(28.0)
                            
                            Button {
                                removeElement(at: array.count - 1)
                            } label: {
                                Text("Pop")
                            }
                            .frame(minWidth: 88)
                            .padding()
                            .background(AppTheme.Colors.lightBrown)
                            .foregroundStyle(.black)
                            .appFont(AppTheme.Fonts.title3)
                            .cornerRadius(28.0)
                        }
                    }
                    
                    NavigationLink {
                        ArrayCodeCheatsheetView()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.right")
                            Text("Pratice")
                                .appFont(AppTheme.Fonts.bodyBold)
                        }
                        .padding()
                        .foregroundStyle(.black)
                        .background(Color(AppTheme.Colors.lightBrown))
                        .cornerRadius(28.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 28.0)
                                .stroke(Color(AppTheme.Colors.mediumBrown), lineWidth: 1.0)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                showInstructions = true
                            }
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(AppTheme.Colors.mediumBrown)
                                .rotationEffect(.degrees(90))
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    InteractiveArrayView()
}
