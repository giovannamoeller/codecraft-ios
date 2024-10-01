//
//  InteractiveQueueView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct InteractiveQueueView: View {
    @StateObject private var queue: CCQueue<Int> = CCQueue()
    @State private var newElement: Int = -1
    @State private var isAnimating: Bool = false
    @State private var animatingElement: QueueElement<Int>?
    @State private var isDequeuing: Bool = false
    @State private var isButtonDisabled: Bool = false
    @State private var frontElement: QueueElement<Int>?
    
    private func enqueue() {
        disableButton()
        newElement = getRandomElement()
        frontElement = nil
        let queueElement = QueueElement(value: newElement)
        withAnimation(.spring(duration: 0.5, bounce: 0.5)) {
            isAnimating = true
            isDequeuing = false
            queue.enqueue(queueElement)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                isAnimating = false
            }
            enableButton()
        }
    }
    
    private func dequeue() {
        disableButton()
        frontElement = nil
        
        withAnimation(.spring(duration: 0.75, bounce: 0.5)) {
            guard let removedElement = queue.dequeue() else { return }
            animatingElement = removedElement
            isAnimating = true
            isDequeuing = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation {
                isAnimating = false
                isDequeuing = false
                animatingElement = nil
            }
            enableButton()
        }
    }
    
    private func front() {
        withAnimation {
            animatingElement = queue.front()
            frontElement = animatingElement
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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Visualize how a queue works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: UsageExample.queue)
                    .padding()
                
                Text("Add or remove elements to see how a queue operates.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if queue.isEmpty {
                    Text("Queue is empty!")
                        .appFont(AppTheme.Fonts.bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(queue.elements) { element in
                                Text("\(element.value)")
                                    .appFont(AppTheme.Fonts.bodyBold)
                                    .padding()
                                    .frame(width: 64, height: 64)
                                    .background(frontElement?.id == element.id ? AppTheme.Colors.eletricBlue : AppTheme.Colors.lightLavender)
                                    .foregroundStyle(frontElement?.id == element.id ? .white : .black)
                                    .cornerRadius(12.0)
                                    .scaleEffect(animatingElement?.id == element.id ? 1.2 : 1.0)
                                    .transition(.asymmetric(insertion: .scale.combined(with: .opacity).combined(with: .slide), removal: .scale.combined(with: .opacity).combined(with: .offset(y: -50))))
                            }
                        }
                        .padding()
                    }
                    .frame(height: 100)
                    .background(AppTheme.Colors.indigo)
                }
                
                HStack {
                    Button(action: enqueue) {
                        CCSecondaryButtonView(text: "Enqueue")
                    }
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.5 : 1)
                    
                    Button(action: dequeue) {
                        CCSecondaryButtonView(text: "Dequeue")
                    }
                    .disabled(isButtonDisabled || queue.isEmpty)
                    .opacity(isButtonDisabled || queue.isEmpty ? 0.5 : 1)
                }
                .padding(.top)
                .frame(maxWidth: 320)
                
                Button(action: front) {
                    CCSecondaryButtonView(text: "Front")
                }
                .disabled(isButtonDisabled || queue.isEmpty)
                .opacity(isButtonDisabled || queue.isEmpty ? 0.5 : 1)
                .frame(maxWidth: 320)
            }
        }
    }
}

#Preview {
    InteractiveQueueView()
}
