//
//  InteractiveArrayView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct InteractiveArrayView: View {
    
    @State private var newElementValue: String = ""
    @State private var insertIndex: String = ""
    @State private var isInserting: Bool = false
    @State private var isRemoving: Bool = false
    @State private var removingIndex: Int?
    @State private var showInstructions = false
    @State private var lastAction: ArrayAction = .none
    @State private var offset: CGFloat = 0
    
    @StateObject private var array = CCDynamicArray<Int>(count: 5) {
        Int.random(in: 0..<100)
    }
    
    enum ArrayAction {
        case none, push, pop
    }
    
    private func pushElement() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            isInserting = true
            lastAction = .push
            array.insertAtLastPosition(Int.random(in: 0..<100))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.spring()) {
                isInserting = false
                lastAction = .none
            }
        }
    }
    
    private func removeElement(at index: Int) {
        guard index >= 0 && index < array.count else { return }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            isRemoving = true
            removingIndex = index
            lastAction = .pop
            offset = 60 // Shift the array to the right
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            array.removeAtLastPosition()
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
            VStack(alignment: .center, spacing: 16.0) {
                Text("Visualize how an array works")
                    .appFont(AppFont.largeTitle)
                    .padding()
                
                // Array view
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8.0) {
                        ForEach(Array(array.elements.enumerated()), id: \.0) { index, element in
                            
                            VStack(spacing: 4.0) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("LightBrown"))
                                        .frame(width: 60, height: 60)
                                    Text("\(element)")
                                        .appFont(AppFont.title3)
                                }
                                Text("\(index)")
                                    .appFont(AppFont.bodyRegular)
                                    .foregroundStyle(Color("DarkGreen"))
                            }
                            .opacity(isRemoving && removingIndex == index ? 0 : 1)
                            .scaleEffect(lastAction == .push && index == array.count - 1 ? 0.5 : 1)
                            .offset(x: lastAction == .push && index == array.count - 1 ? 70 : 0)
                            .offset(y: lastAction == .pop && index == array.count - 1 ? 50 : 0)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .padding()
                    .offset(x: offset) // Apply the offset here
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
                        .background(Color("DarkGreen"))
                        .foregroundStyle(.white)
                        .appFont(AppFont.title)
                        .cornerRadius(28.0)
                        
                        Button {
                            removeElement(at: array.count - 1)
                        } label: {
                            Text("Pop")
                        }
                        .frame(minWidth: 88)
                        .padding()
                        .background(Color("LightBrown"))
                        .foregroundStyle(.black)
                        .appFont(AppFont.title)
                        .cornerRadius(28.0)
                    }
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
                            .foregroundStyle(Color("MediumBrown"))
                            .rotationEffect(.degrees(90))
                    }
                }
            }
        }
    }
}

#Preview {
    InteractiveArrayView()
}
