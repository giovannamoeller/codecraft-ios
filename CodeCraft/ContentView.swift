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
                .appFont(AppFont.title)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
