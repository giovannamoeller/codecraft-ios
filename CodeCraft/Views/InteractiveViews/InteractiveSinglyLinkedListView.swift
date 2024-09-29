//
//  InteractiveSinglyLinkedListView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

enum LinkedListAction {
    case none, insertFirst, insertLast, removeFirst, removeLast
}

struct InteractiveSinglyLinkedListView: View {
    @StateObject private var linkedList = CCSinglyLinkedList<Int>()
    @State private var animatingNodeIndex: Int = -1
    @State private var lastAction: LinkedListAction = .none
    @State private var newElement: Int?
    @State private var isAnimating: Bool = false
    @State private var isButtonDisabled: Bool = false
    @State private var isRemovingElement: Bool = false
    @State private var removedElement: Int?
    
    let analogies: [Analogy] = [
        Analogy(icon: "link", title: "Node-based", description: "Linked lists consist of nodes, each containing data and a reference to the next node."),
        Analogy(icon: "arrow.right", title: "Sequential access", description: "Elements are accessed sequentially, starting from the head."),
        Analogy(icon: "plus.circle", title: "Dynamic size", description: "Linked lists can grow or shrink dynamically as needed."),
        Analogy(icon: "bolt", title: "Efficient insertions", description: "Inserting elements at the beginning or end is very efficient (O(1) time)."),
    ]
    
    private func getRandomElement() -> Int {
        return Int.random(in: 0..<100)
    }
    
    private func insertFirst() {
        isButtonDisabled = true
        lastAction = .insertFirst
        let elementToInsert = getRandomElement()
        
        withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
            newElement = elementToInsert
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.spring(duration: 0.5)) {
                isAnimating = true
                animatingNodeIndex = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            animatingNodeIndex = -1
            isAnimating = false
            linkedList.insertAtHead(elementToInsert)
            newElement = nil
            withAnimation {
                isButtonDisabled = false
            }
            lastAction = .none
        }
    }
    
    private func insertLast() {
        isButtonDisabled = true
        lastAction = .insertLast
        let elementToInsert = getRandomElement()
        
        withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
            newElement = elementToInsert
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring(duration: 0.5)) {
                isAnimating = true
                animatingNodeIndex = linkedList.length
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            animatingNodeIndex = -1
            isAnimating = false
            linkedList.insertAtTail(elementToInsert)
            newElement = nil
            withAnimation {
                isButtonDisabled = false
            }
            lastAction = .none
        }
    }
    
    private func removeFirst() {
        guard !linkedList.isEmpty else { return }
        isButtonDisabled = true
        lastAction = .removeFirst
        animatingNodeIndex = 0
        
        // Start the animation for removing the first element
        withAnimation(.easeInOut(duration: 0.5)) {
            isAnimating = true
            isRemovingElement = true
            removedElement = linkedList.head?.value
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Remove the element after a delay
            
            withAnimation {
                _ = linkedList.removeAtHead()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                animatingNodeIndex = -1
                isAnimating = false
                isButtonDisabled = false
                lastAction = .none
                isRemovingElement = false
                removedElement = nil
                
            }
        }
    }
    
    
    private func removeLast() {
        guard !linkedList.isEmpty else { return }
        isButtonDisabled = true
        lastAction = .removeLast
        animatingNodeIndex = linkedList.length - 1
        
        
        withAnimation(.easeInOut(duration: 0.5)) {
            isAnimating = true
            isRemovingElement = true
            removedElement = linkedList.tail?.value
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                let _ = linkedList.removeAtTail()
                isAnimating = false
                isRemovingElement = false
                animatingNodeIndex = -1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                isButtonDisabled = false
                lastAction = .none
                removedElement = nil
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Visualize how a singly linked list works")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding(32)
                
                CCFlexibleGridView(data: analogies)
                    .padding()
                
                Text("Observe how the linked list changes as you perform operations below.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if linkedList.isEmpty && newElement == nil {
                    Text("Linked list is empty!")
                        .appFont(AppTheme.Fonts.bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8.0) {
                            if newElement != nil && lastAction == .insertFirst {
                                CCSinglyNodeView(
                                    element: newElement!,
                                    isHead: true,
                                    isTail: linkedList.isEmpty
                                )
                                .opacity(isAnimating ? 1 : 0)
                                .scaleEffect(isAnimating ? 1 : 0.5)
                                .offset(y: isAnimating ? 0 : -50)
                                .animation(.spring(bounce: 0.5), value: isAnimating)
                            }
                            
                            ForEach(Array(linkedList.toArray().enumerated()), id: \.element) { index, element in
                                CCSinglyNodeView(
                                    element: element,
                                    isHead: index == 0 && (lastAction != .insertFirst || !isAnimating),
                                    isTail: index == linkedList.length - 1 && (lastAction != .insertLast || !isAnimating)
                                )
                                .opacity(removedElement == element ? 0 : 1)
                                .scaleEffect(removedElement == element ? 0.5 : 1)
                                .offset(y: removedElement == element ? -50 : 0)
                            }
                            .animation(.spring(bounce: 0.5), value: removedElement)
                            //.transition(.asymmetric(insertion: .scale, removal: .opacity))
                            
                            if newElement != nil && lastAction == .insertLast {
                                CCSinglyNodeView(
                                    element: newElement!,
                                    isHead: linkedList.isEmpty,
                                    isTail: true
                                )
                                .opacity(isAnimating ? 1 : 0)
                                .scaleEffect(isAnimating ? 1 : 0.5)
                                .offset(y: isAnimating ? 0 : -50)
                                .animation(.spring(bounce: 0.5), value: isAnimating)
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical, 32)
                        .padding(.top)
                    }
                    .background(AppTheme.Colors.indigo)
                    .padding(.vertical)
                }
                
                HStack {
                    Button(action: insertFirst) {
                        CCSecondaryButtonView(text: "Insert First")
                    }
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.5 : 1)
                    
                    Button(action: insertLast) {
                        CCSecondaryButtonView(text: "Insert Last")
                    }
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.5 : 1)
                }
                .frame(maxWidth: 320)
                
                HStack {
                    Button(action: removeFirst) {
                        CCSecondaryButtonView(text: "Remove First")
                    }
                    .disabled(isButtonDisabled || linkedList.isEmpty)
                    .opacity(isButtonDisabled || linkedList.isEmpty ? 0.5 : 1)
                    
                    Button(action: removeLast) {
                        CCSecondaryButtonView(text: "Remove Last")
                    }
                    
                    .disabled(isButtonDisabled || linkedList.isEmpty)
                    .opacity(isButtonDisabled || linkedList.isEmpty ? 0.5 : 1)
                    
                }
                .frame(maxWidth: 320)
                
                NavigationLink {
                    //LinkedListCodeCheatsheetView()
                } label: {
                    CCPrimaryButtonView(text: "Practice")
                        .padding(.top, 32)
                }
            }
        }
        .onAppear {
            for _ in 0..<3 {
                linkedList.insertAtHead(getRandomElement())
            }
        }
    }
}

#Preview {
    InteractiveSinglyLinkedListView()
}
