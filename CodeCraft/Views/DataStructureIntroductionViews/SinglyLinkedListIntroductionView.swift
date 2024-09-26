//
//  SinglyLinkedListIntroductionView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct SinglyLinkedListIntroductionView: View {
    let singlyLinkedListInformation = DataStructureInformation(
        title: "singly linked lists",
        imageName: "3d-illustration-03",
        definition: "A singly linked list is a linear data structure where each element (node) contains data and a reference to the next node in the sequence. The last node points to null, indicating the end of the list.",
        analogies: [
            Analogy(icon: "person.3", title: "Conga line", description: "Each person holds the next person's shoulders."),
            Analogy(icon: "train.side.front.car", title: "Train cars", description: "Each car is connected to the next one."),
            Analogy(icon: "text.book.closed", title: "Choose Your Adventure", description: "Each page points to the next part of the story."),
            Analogy(icon: "link", title: "Treasure Hunt", description: "Each clue leads to the location of the next clue.")
        ],
        useCases: [
            "When frequent insertion and deletion at the beginning is needed.",
            "For implementing undo functionality in applications.",
            "In symbol tables of compiler design.",
            "For implementing forward and backward functionality in music players."
        ]
    )
    
    var body: some View {
        DataStructureIntroductionView(dataStructure: singlyLinkedListInformation) {
            //
        }
    }
}

#Preview {
    SinglyLinkedListIntroductionView()
}
