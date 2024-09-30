//
//  InteractiveStackView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct InteractiveStackView: View {
    @StateObject private var stack: CCStack<Int> = CCStack()
    @State private var newElement: Int = -1
    @State private var isAnimating: Bool = false
    @State private var animatingElement: StackElement<Int>?
    @State private var isPopping: Bool = false
    @State private var isButtonDisabled: Bool = false
    @State private var peekedElement: StackElement<Int>?
    
    let analogies: [Analogy] = [
        Analogy(icon: "tray.and.arrow.up.fill", title: "Last In, First Out (LIFO)", description: "Like a stack of plates, the last item added is the first one removed."),
        Analogy(icon: "book.closed.fill", title: "Browser History", description: "Navigating back through web pages works like a stack."),
        Analogy(icon: "arrow.uturn.backward", title: "Undo Functionality", description: "The undo feature in many applications uses a stack to keep track of actions."),
        Analogy(icon: "cpu", title: "Function Call Stack", description: "Computer memory uses a stack to manage function calls and returns."),
    ]
    
    private func push() {
        disableButton()
        newElement = getRandomElement()
        peekedElement = nil
        let stackElement = StackElement(value: newElement)
        withAnimation(.spring(duration: 0.5, bounce: 0.5)) {
            isAnimating = true
            isPopping = false
            stack.push(stackElement)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                isAnimating = false
            }
            enableButton()
        }
    }
    
    private func pop() {
        disableButton()
        peekedElement = nil
        withAnimation(.spring(duration: 0.5, bounce: 0.5)) {
            guard let _ = stack.pop() else { return }
            isAnimating = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                isAnimating = false
            }
            enableButton()
        }
    }
    
    private func peek() {
        withAnimation {
            peekedElement = stack.peek()
        }
    }
    
    private func disableButton() {
        withAnimation {
            isButtonDisabled = true
        }
    }
    
    private func enableButton() {
        withAnimation {
            isButtonDisabled = false
        }
    }
    
    private func getRandomElement() -> Int {
        return Int.random(in: 0..<100)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Visualize how a stack works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: analogies)
                    .padding()
                
                Text("Add or remove elements to see how a stack operates.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if stack.isEmpty {
                    Text("Stack is empty!")
                        .appFont(AppTheme.Fonts.bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(stack.elements.reversed()) { element in
                            Text("\(element.value)")
                                .appFont(AppTheme.Fonts.bodyBold)
                                .padding()
                                .frame(maxWidth: 124)
                                .background(peekedElement?.id == element.id ? AppTheme.Colors.eletricBlue : AppTheme.Colors.lightLavender)
                                .foregroundStyle(peekedElement?.id == element.id ? .white : .black)
                                .cornerRadius(12.0)
                                .scaleEffect(animatingElement?.id == element.id ? (isPopping ? 0.5 : 1.2) : 1)
                                .scaleEffect(peekedElement?.id == element.id ? 1.2 : 1.0)
                                .opacity(animatingElement?.id == element.id && isPopping ? 0 : 1)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.1), value: animatingElement?.id)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.1), value: peekedElement?.id)
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
    }
}

#Preview {
    InteractiveStackView()
}
