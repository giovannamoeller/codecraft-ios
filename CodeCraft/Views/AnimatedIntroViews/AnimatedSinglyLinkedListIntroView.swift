//
//  AnimatedSinglyLinkedListIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct AnimatedSinglyLinkedListIntroView: View {
    var body: some View {
        AnimatedIntroView(title: "Singly Linked List", sectionNumber: 2) {
            SinglyLinkedListIntroductionView()
        }
    }
}

#Preview {
    AnimatedSinglyLinkedListIntroView()
}
