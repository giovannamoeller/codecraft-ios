//
//  AnimatedSinglyLinkedListIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct AnimatedSinglyLinkedListIntroView: View {
    let dataStructure: DataStructure = .singlyLinkedList

    var body: some View {
        AnimatedIntroView(dataStructure: dataStructure) {
            SinglyLinkedListIntroductionView()
        }
    }
}

#Preview {
    AnimatedSinglyLinkedListIntroView()
}
