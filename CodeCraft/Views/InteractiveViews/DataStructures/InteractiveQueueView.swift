//
//  InteractiveQueueView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct InteractiveQueueView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @StateObject private var queue: Queue<Int> = Queue<Int>()
    @State private var isButtonDisabled = false
    @State private var scrollTarget: Int?
    @State private var frontElement: QueueElement<Int>?
    
    private let baseSeconds: Double = 0.5
    
    private var itemSize: CGFloat {
        return horizontalSizeClass == .compact ? 54.0 : 64.0
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                InteractiveHeaderView(text: "Visualize how a queue works", data: UsageExample.queue, guideline: "Add or remove elements to see how a queue operates.")
                
                if queue.isEmpty {
                    ResponsiveTextView(text: "Queue is empty!", style: .bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(queue.elements) { element in
                                ResponsiveTextView(text: "\(element.value)", style: .bodyBold, alignment: .center)
                                    .padding()
                                    .frame(width: itemSize, height: itemSize)
                                    .background(frontElement?.id == element.id ? AppTheme.Colors.eletricBlue : AppTheme.Colors.lightLavender)
                                    .foregroundStyle(frontElement?.id == element.id ? .white : .black)
                                    .cornerRadius(12.0)
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
                        SecondaryButtonView(text: "Enqueue",
                                              isDisabled: isButtonDisabled)
                    }
                    
                    Button(action: dequeue) {
                        SecondaryButtonView(text: "Dequeue",
                                              isDisabled: isButtonDisabled || queue.isEmpty)
                    }
                }
                .padding(.top)
                .frame(maxWidth: 320)
                
                Button(action: front) {
                    SecondaryButtonView(text: "Front",
                                          isDisabled: isButtonDisabled || queue.isEmpty)
                }
                .frame(maxWidth: 320)
            }
            .onAppear {
                initializeQueue()
            }
        }
    }
    
    private func initializeQueue() {
        queue.removeAll()
        let numberOfElements = 3
        for _ in 0..<numberOfElements {
            let newElement = getRandomElement()
            queue.enqueue(QueueElement(value: newElement))
        }
    }
    
    private func enqueue() {
        disableButton()
        let elementToInsert = getRandomElement()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = elementToInsert
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                queue.enqueue(QueueElement(value: elementToInsert))
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func dequeue() {
        disableButton()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = queue.front()?.value
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                _ = queue.dequeue()
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func front() {
        withAnimation(.spring(duration: baseSeconds * 2, bounce: 0.3)) {
            frontElement = queue.front()
        }
        
        executeAfter(baseSeconds * 4) {
            withAnimation(.spring(duration: baseSeconds * 2, bounce: 0.3)) {
                frontElement = nil
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
    InteractiveQueueView()
}
