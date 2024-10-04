//
//  InteractiveStackView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct InteractiveStackView: View {
    @StateObject private var stack: Stack<Int> = Stack<Int>()
    @State private var isButtonDisabled = false
    @State private var scrollTarget: Int?
    @State private var peekElement: StackElement<Int>?
    
    private let baseSeconds: Double = 0.5
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                ResponsiveTextView(text: "Visualize how a stack works", style: .title)
                    .padding(.horizontal)
                
                CCFlexibleGridView(data: UsageExample.stack)
                    .padding(.horizontal)
                
                ResponsiveTextView(text: "Add or remove elements to see how a stack operates.", style: .bodyRegular)
                    .padding(.horizontal)
                
                if stack.isEmpty {
                    ResponsiveTextView(text: "Stack is empty!", style: .bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(stack.elements.reversed()) { element in
                            ResponsiveTextView(text: "\(element.value)", style: .bodyBold, alignment: .center)
                                .padding()
                                .frame(maxWidth: 124)
                                .background(peekElement?.id == element.id ? AppTheme.Colors.eletricBlue : AppTheme.Colors.lightLavender)
                                .foregroundStyle(peekElement?.id == element.id ? .white : .black)
                                .cornerRadius(12.0)
                                .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .scale.combined(with: .opacity)))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .background(AppTheme.Colors.indigo)
                }
                
                HStack {
                    Button(action: push) {
                        CCSecondaryButtonView(text: "Push")
                    }
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.5 : 1)
                    
                    Button(action: pop) {
                        CCSecondaryButtonView(text: "Pop")
                    }
                    
                    .disabled(isButtonDisabled || stack.isEmpty)
                    .opacity(isButtonDisabled || stack.isEmpty ? 0.5 : 1)
                }
                .frame(maxWidth: 320)
                
                Button(action: peek) {
                    CCSecondaryButtonView(text: "Peek")
                }
                .disabled(isButtonDisabled || stack.isEmpty)
                .opacity(isButtonDisabled || stack.isEmpty ? 0.5 : 1)
                .frame(maxWidth: 320)
            }
        }
        .onAppear {
            initializeStack()
        }
    }
    
    private func initializeStack() {
        stack.removeAll()
        let numberOfElements = 3
        for _ in 0..<numberOfElements {
            let newElement = getRandomElement()
            stack.push(StackElement(value: newElement))
        }
    }
    
    private func push() {
        disableButton()
        let elementToInsert = getRandomElement()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = elementToInsert
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                stack.push(StackElement(value: elementToInsert))
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func pop() {
        disableButton()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = stack.peek()?.value
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                _ = stack.pop()
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func peek() {
        withAnimation(.spring(duration: baseSeconds * 2, bounce: 0.3)) {
            peekElement = stack.peek()
        }
        
        executeAfter(baseSeconds * 4) {
            withAnimation(.spring(duration: baseSeconds * 2, bounce: 0.3)) {
                peekElement = nil
            }
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
}

#Preview {
    InteractiveStackView()
}
