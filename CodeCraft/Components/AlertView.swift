//
//  AlertView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct AlertView: View {
    let title: String
    let message: String
    let buttonTitle: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 16.0) {
            ResponsiveTextView(text: title,
                               style: .title,
                               alignment: .center)
            
            ResponsiveTextView(text: message,
                               style: .bodyRegular,
                               alignment: .center)
            
            Button {
                isPresented = false
            } label: {
                PrimaryButtonView(text: buttonTitle, displayIcon: false)
                    .padding(.top)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22.0)
        .shadow(radius: 12.0)
        .frame(maxWidth: 424)
    }
}

#Preview {
    AlertView(title: "Custom Alert", message: "Hello, World!", buttonTitle: "Ok", isPresented: .constant(true))
}
