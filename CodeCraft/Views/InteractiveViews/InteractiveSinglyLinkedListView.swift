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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var maxHeight: CGFloat = 0
    
    @State private var lastAction: LinkedListAction = .none
    @State private var showInstructions = false
    @State private var animatingNodeIndex: Int?
    
    @StateObject private var linkedList = CCSinglyLinkedList<Int>()
    
    let analogies: [Analogy] = [
        Analogy(icon: "link", title: "Node-based", description: "Linked lists consist of nodes, each containing data and a reference to the next node."),
        Analogy(icon: "arrow.right", title: "Sequential access", description: "Elements are accessed sequentially, starting from the head."),
        Analogy(icon: "plus.circle", title: "Dynamic size", description: "Linked lists can grow or shrink dynamically as needed."),
        Analogy(icon: "bolt", title: "Efficient insertions", description: "Inserting elements at the beginning or end is very efficient (O(1) time)."),
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    private func getRandomElement() -> Int {
        return Int.random(in: 0..<100)
    }
    
    private func insertFirst() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            lastAction = .insertFirst
            linkedList.insertAtHead(getRandomElement())
            animatingNodeIndex = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.spring()) {
                lastAction = .none
                animatingNodeIndex = nil
            }
        }
    }
    
    private func insertLast() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            lastAction = .insertLast
            linkedList.insertAtTail(getRandomElement())
            animatingNodeIndex = linkedList.length - 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.spring()) {
                lastAction = .none
                animatingNodeIndex = nil
            }
        }
    }
    
    private func removeFirst() {
        guard !linkedList.isEmpty else { return }
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            lastAction = .removeFirst
            animatingNodeIndex = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let _ = linkedList.removeAtHead()
            withAnimation(.spring()) {
                lastAction = .none
                animatingNodeIndex = nil
            }
        }
    }
    
    private func removeLast() {
        guard !linkedList.isEmpty else { return }
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            lastAction = .removeLast
            animatingNodeIndex = linkedList.length - 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let _ = linkedList.removeAtTail()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                lastAction = .none
                animatingNodeIndex = nil
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16.0) {
                Text("Visualize how a singly linked list works")
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding()
                
                CCFlexibleGridView(data: analogies)
                
                Text("Observe how the linked list changes as you perform operations below.")
                    .appFont(AppTheme.Fonts.bodyRegular)
                    .padding(.top)
                
                if linkedList.isEmpty {
                    Text("Linked list is empty!")
                        .appFont(AppTheme.Fonts.bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8.0) {
                            ForEach(Array(linkedList.toArray().enumerated()), id: \.0) { index, element in
                                HStack(spacing: 4.0) {
                                    ZStack {
                                        Circle()
                                            .fill(AppTheme.Colors.lightLavender)
                                            .frame(width: 64, height: 64)
                                        Text("\(element)")
                                            .appFont(AppTheme.Fonts.title3)
                                    }
                                    if index < linkedList.length - 1 {
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(AppTheme.Colors.indigo)
                                    }
                                }
                                .opacity(animatingNodeIndex == index ? 0.5 : 1)
                                .scaleEffect(animatingNodeIndex == index ? 0.8 : 1)
                                .offset(x: lastAction == .insertFirst && index == 0 ? 70 : 0)
                                .offset(x: lastAction == .insertLast && index == linkedList.length - 1 ? -70 : 0)
                                .offset(y: (lastAction == .removeFirst && index == 0) || (lastAction == .removeLast && index == linkedList.length - 1) ? 50 : 0)
                            }
                        }
                        .frame(minHeight: 164)
                        .padding()
                    }
                    .padding(.vertical, 32)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3), value: linkedList.length)
                }
                
                VStack(spacing: 15) {
                    HStack {
                        Button(action: insertFirst) {
                            CCSecondaryButtonView(text: "Insert First")
                        }
                        Spacer()
                        Button(action: insertLast) {
                            CCSecondaryButtonView(text: "Insert Last")
                        }
                    }
                    .frame(maxWidth: 320)
                    //.background(Color.red)
                    HStack {
                        Button(action: removeFirst) {
                            CCSecondaryButtonView(text: "Remove First")
                        }
                        Spacer()
                        Button(action: removeLast) {
                            CCSecondaryButtonView(text: "Remove Last")
                        }
                    }
                    .frame(maxWidth: 320)
                    //.background(Color.blue)
                }
                
                NavigationLink {
                    //LinkedListCodeCheatsheetView()
                } label: {
                    CCPrimaryButtonView(text: "Practice")
                        .padding(.top, 32)
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
                            .foregroundStyle(AppTheme.Colors.mediumLavender)
                            .rotationEffect(.degrees(90))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    InteractiveSinglyLinkedListView()
}
