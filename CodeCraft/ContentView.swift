//
//  ContentView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("What's an array?")
                .font(plusJakartaSans(size: 24, weight: .bold))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
