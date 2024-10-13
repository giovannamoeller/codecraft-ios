//
//  ConfettiLottieView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 12/10/24.
//

import SwiftUI
import Lottie

struct ConfettiLottieView: View {
    var body: some View {
        LottieView(animation: .named("ConfettiLottieAnimation"))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
    }
}

#Preview {
    ConfettiLottieView()
}
