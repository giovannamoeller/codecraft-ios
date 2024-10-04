//
//  InteractiveLinkedListView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 01/10/24.
//

import SwiftUI

struct InteractiveLinkedListView<T: LinkedListProtocol, NodeView: LinkedListNodeViewProtocol>: View where NodeView.Element == T.Element {
    
    @StateObject private var linkedList: T
    @State private var isButtonDisabled = false
    @State private var scrollTarget: T.Element?
    
    private let baseSeconds: Double = 0.5
    private let title: String
    private let description: String
    private let usageExample: [GridData]
    
    init(linkedList: T,
         title: String,
         description: String,
         usageExample: [GridData]) {
        _linkedList = StateObject(wrappedValue: linkedList)
        self.title = title
        self.description = description
        self.usageExample = usageExample
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                ResponsiveTextView(text: title, style: .title)
                    .padding()
                
                CCFlexibleGridView(data: usageExample)
                    .padding()
                
                ResponsiveTextView(text: description, style: .bodyRegular)
                    .padding()
                
                if linkedList.isEmpty {
                    ResponsiveTextView(text: "\(title) is empty!", style: .bodyBold)
                        .padding(.vertical)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8.0) {
                                ForEach(Array(linkedList.toArray().enumerated()), id: \.element) { index, element in
                                    NodeView(
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
                        .onChange(of: scrollTarget) { _, target in
                            if let target {
                                withAnimation {
                                    proxy.scrollTo(target, anchor: .center)
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: { insertElement(linkedList.insertAtHead) }) {
                            CCSecondaryButtonView(text: "Insert First",
                                                  isDisabled: isButtonDisabled)
                        }
                        
                        Button(action: { insertElement(linkedList.insertAtTail) }) {
                            CCSecondaryButtonView(text: "Insert Last",
                                                  isDisabled: isButtonDisabled)
                        }
                    }
                    .frame(maxWidth: 320)
                    
                    HStack {
                        Button(action: { removeElement(linkedList.removeAtHead) }) {
                            CCSecondaryButtonView(text: "Remove First",
                                                  isDisabled: isButtonDisabled || linkedList.isEmpty)
                        }
                        
                        Button(action: { removeElement(linkedList.removeAtTail) }) {
                            CCSecondaryButtonView(text: "Remove Last",
                                                  isDisabled: isButtonDisabled || linkedList.isEmpty)
                        }
                    }
                    .frame(maxWidth: 320)
                }
            }
        }
        .onAppear {
            initializeLinkedList()
        }
    }
    
    private func initializeLinkedList() {
        linkedList.removeAll()
        let numberOfElements = 3
        for _ in 0..<numberOfElements {
            linkedList.insertAtHead(getRandomElement() as! T.Element)
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
    
    private func insertElement(_ insertionMethod: @escaping (T.Element) -> Void) {
        disableButton()
        let elementToInsert = getRandomElement() as! T.Element
        
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
    
    private func removeElement(_ removalMethod: @escaping () -> T.Element?) {
        disableButton()
        
        withAnimation(.spring(duration: baseSeconds, bounce: 0.3)) {
            scrollTarget = linkedList.toArray().first
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
    InteractiveLinkedListView<SinglyLinkedList<Int>, SinglyNodeView>(
        linkedList: SinglyLinkedList<Int>(),
        title: "Visualize how a singly linked list works",
        description: "Observe how the linked list changes as you perform operations below.",
        usageExample: UsageExample.singlyLinkedList
    )
}
