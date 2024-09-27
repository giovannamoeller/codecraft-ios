//
//  CCAlertView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct CCAlertView: View {
    let title: String
    let message: String
    let buttonTitle: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .appFont(AppTheme.Fonts.title)
            
            Text(message)
                .appFont(AppTheme.Fonts.bodyRegular)
                .frame(maxWidth: 264)
                .multilineTextAlignment(.center)
            
            Button {
                isPresented = false
            } label: {
                CCPrimaryButtonView(text: buttonTitle, displayIcon: false)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    CCAlertView(title: "Custom Alert", message: "Hello, World!", buttonTitle: "Ok", isPresented: .constant(true))
}
