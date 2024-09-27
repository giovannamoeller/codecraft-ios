//
//  AnimatedArrayIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct AnimatedArrayIntroView: View {
    var body: some View {
        AnimatedIntroView(title: "Arrays", sectionNumber: 1) {
            ArrayIntroductionView()
        }
    }
}

#Preview {
    AnimatedArrayIntroView()
}
