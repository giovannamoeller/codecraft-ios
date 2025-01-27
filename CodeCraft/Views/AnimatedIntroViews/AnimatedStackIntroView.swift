//
//  AnimatedStackIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct AnimatedStackIntroView: View {
    let dataStructure: DataStructure = .stack

    var body: some View {
        AnimatedIntroView(dataStructure: dataStructure) {
            //
        }
    }
}

#Preview {
    AnimatedStackIntroView()
}
