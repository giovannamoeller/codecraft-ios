//
//  InteractiveArrayView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct InteractiveArrayView<T: Hashable & RandomElementGeneratable>: View {
    @StateObject private var array: DynamicArray<T> = DynamicArray<T>()
    @State private var isButtonDisabled = false
    @State private var scrollTarget: T?
    
    private let baseSeconds: Double = 0.5
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16.0) {
                Text("Visualize how an array works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                
                CCFlexibleGridView(data: UsageExample.array)
                
                Text("Observe how the array changes as you perform operations below.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.bodyRegular)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8.0) {
                        ForEach(0..<array.count, id: \.self) { index in
                            VStack(spacing: 4.0) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(AppTheme.Colors.lightLavender)
                                        .frame(width: 60, height: 60)
                                    Text("\(array.elements[index])")
                                        .appFont(AppTheme.Fonts.title3)
                                }
                                Text("\(index)")
                                    .appFont(AppTheme.Fonts.bodyRegular)
                                    .foregroundStyle(AppTheme.Colors.indigo)
                            }
                        }
                        .transition(.asymmetric(insertion: .scale.combined(with: .opacity).combined(with: .slide), removal: .scale.combined(with: .opacity).combined(with: .offset(y: -50)).combined(with: .offset(x: -50))))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .padding(.vertical)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3), value: array.count)
                
                HStack {
                    Button {
                        push()
                    } label: {
                        CCSecondaryButtonView(text: "Push")
                    }
                    
                    Button {
                        pop()
                    } label: {
                        CCSecondaryButtonView(text: "Pop")
                    }
                }
                .frame(maxWidth: 320)
                
                NavigationLink {
                    ArrayCodeCheatsheetView()
                } label: {
                    CCPrimaryButtonView(text: "Practice")
                        .padding(.top)
                }
            }
            .padding()
            .onAppear {
                initializeArray()
            }
        }
    }
    
    private func initializeArray() {
        array.removeAll()
        let numberOfElements = 3
        for _ in 0..<numberOfElements {
            array.insertAtLastPosition(T.getRandomElement())
        }
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
    
    private func push() {
        insertElement( { array.insertAtLastPosition($0) } )
    }
    
    private func pop() {
        removeElement( { array.removeAtLastPosition() } )
    }
    
    private func insertElement(_ insertionMethod: @escaping (T) -> Void) {
        disableButton()
        let elementToInsert = T.getRandomElement()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = elementToInsert
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                insertionMethod(elementToInsert)
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func removeElement(_ removalMethod: @escaping () -> T?) {
        disableButton()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = array.elements[array.count - 1]
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                _ = removalMethod()
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
}

#Preview {
    InteractiveArrayView<String>()
}
