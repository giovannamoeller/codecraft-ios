//
//  AnimatedArrayIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct AnimatedArrayIntroView: View {
    let dataStructure: DataStructure = .array
    
    var body: some View {
        AnimatedIntroView(dataStructure: dataStructure) {
            ArrayIntroductionView()
        }
    }
}

#Preview {
    AnimatedArrayIntroView()
}
