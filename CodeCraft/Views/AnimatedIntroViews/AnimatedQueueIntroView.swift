//
//  AnimatedQueueIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct AnimatedQueueIntroView: View {
    let dataStructure: DataStructure = .queue

    var body: some View {
        AnimatedIntroView(title: dataStructure.title,
                          sectionNumber: dataStructure.sectionNumber) {
            //
        }
    }
}

#Preview {
    AnimatedQueueIntroView()
}
