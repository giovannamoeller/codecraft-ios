//
//  InteractiveDoublyLinkedListView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//

import SwiftUI

struct InteractiveDoublyLinkedListView: View {
    @StateObject private var linkedList = CCDoublyLinkedList<Int>()
    
    @State private var isButtonDisabled: Bool = false
    @State private var scrollTarget: Int?
    @State private var baseSeconds: Double = 0.5
    
    private func initializeLinkedList() {
        linkedList.removeAll()
        
        let numberOfElements: Int = 3
        for _ in 0..<numberOfElements {
            linkedList.insertAtHead(getRandomElement())
        }
    }
    
    private func insertFirst() {
        disableButton()
        let elementToInsert: Int = getRandomElement()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = elementToInsert
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                linkedList.insertAtHead(elementToInsert)
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func insertLast() {
        disableButton()
        let elementToInsert: Int = getRandomElement()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = elementToInsert
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                linkedList.insertAtTail(elementToInsert)
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func removeFirst() {
        
        disableButton()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = linkedList.head?.value
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                _ = linkedList.removeAtHead()
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
        }
    }
    
    private func removeLast() {
        disableButton()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = linkedList.tail?.value
        }
        
        executeAfter(baseSeconds) {
            withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
                _ = linkedList.removeAtTail()
            }
        }
        
        executeAfter(baseSeconds * 2.0) {
            enableButton()
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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Visualize how a doubly linked list works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: UsageExample.doublyLinkedList)
                    .padding()
                
                Text("Observe how the doubly linked list changes as you perform operations below.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if linkedList.isEmpty {
                    Text("Doubly linked list is empty!")
                        .appFont(AppTheme.Fonts.bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8.0) {
                                ForEach(Array(linkedList.toArray().enumerated()), id: \.element) { index, element in
                                    CCDoublyNodeView(
                                        element: element,
                                        isHead: index == 0,
                                        isTail: index == linkedList.length - 1
                                    )
                                    .id(element)
                                }
                                .transition(.asymmetric(insertion: .scale.combined(with: .opacity).combined(with: .slide), removal: .scale.combined(with: .opacity).combined(with: .offset(y: -50))))
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 32)
                            .padding(.top)
                        }
                        .background(AppTheme.Colors.indigo)
                        .padding(.vertical)
                        .onChange(of: scrollTarget, { _, target in
                            if let target {
                                withAnimation {
                                    proxy.scrollTo(target, anchor: .center)
                                }
                            }
                        })
                    }
                }
                
                HStack {
                    Button(action: insertFirst) {
                        CCSecondaryButtonView(text: "Insert First",
                                              isDisabled: isButtonDisabled)
                    }
                    
                    Button(action: insertLast) {
                        CCSecondaryButtonView(text: "Insert Last",
                                              isDisabled: isButtonDisabled
                        )
                    }
                }
                .frame(maxWidth: 320)
                
                HStack {
                    Button(action: removeFirst) {
                        CCSecondaryButtonView(text: "Remove First",
                                              isDisabled: isButtonDisabled || linkedList.isEmpty)
                    }
                    
                    Button(action: removeLast) {
                        CCSecondaryButtonView(text: "Remove Last",
                                              isDisabled: isButtonDisabled || linkedList.isEmpty)
                    }
                    
                }
                .frame(maxWidth: 320)
                
                NavigationLink {
                    // DoublyLinkedListCodeCheatsheetView()
                } label: {
                    CCPrimaryButtonView(text: "Practice")
                        .padding(.top, 32)
                }
            }
        }
        .onAppear {
            initializeLinkedList()
        }
    }
}

#Preview {
    InteractiveDoublyLinkedListView()
}
