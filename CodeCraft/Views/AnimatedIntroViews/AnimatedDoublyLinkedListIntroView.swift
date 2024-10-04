//
//  AnimatedDoublyLinkedListIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct AnimatedDoublyLinkedListIntroView: View {
    let dataStructure: DataStructure = .doublyLinkedList

    var body: some View {
        AnimatedIntroView(title: dataStructure.title,
                          sectionNumber: dataStructure.sectionNumber) {
            //
        }
    }
}

#Preview {
    AnimatedDoublyLinkedListIntroView()
}
