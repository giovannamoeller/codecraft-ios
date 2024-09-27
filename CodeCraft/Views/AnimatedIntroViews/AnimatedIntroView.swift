//
//  AnimatedIntroView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct AnimatedIntroView<Destination: View>: View {
    @State private var circleScale: CGFloat = 0.1
    @State private var circleOffset: CGFloat = -300
    @State private var showContent: Bool = false
    
    let title: String
    let sectionNumber: Int
    let destination: Destination
    
    init(title: String,
         sectionNumber: Int,
         @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.sectionNumber = sectionNumber
        self.destination = destination()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                Circle()
                    .fill(AppTheme.Colors.darkGreen)
                    .scaleEffect(circleScale)
                    .offset(y: circleOffset)
                    .animation(.spring(response: 5, dampingFraction: 0.8, blendDuration: 0), value: circleScale)
                    .animation(.spring(response: 8, dampingFraction: 0.8, blendDuration: 0.5), value: circleOffset)
                
                VStack {
                    
                    Text("Section \(sectionNumber)".uppercased())
                        .appFont(AppTheme.Fonts.title)
                        .kerning(2.5)
                        .foregroundStyle(.white)
                        .opacity(showContent ? 1 : 0)
                        .scaleEffect(showContent ? 1 : 0.5)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5).delay(0.2), value: showContent)
                        .padding(.vertical)
                    
                    
                    Text(title)
                        .appFont(AppTheme.Fonts.extraLargeTitle)
                        .foregroundStyle(.white)
                        .opacity(showContent ? 1 : 0)
                        .scaleEffect(showContent ? 1 : 0.5)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5).delay(0.5), value: showContent)
                    
                    NavigationLink {
                        destination
                    } label: {
                        HStack {
                            Text("Let's get started")
                                .appFont(AppTheme.Fonts.title3)
                            Image(systemName: "arrow.right")
                        }
                        .frame(minWidth: 188)
                        .padding()
                        .background(AppTheme.Colors.mediumBrown)
                        .foregroundStyle(.white)
                        .cornerRadius(28.0)
                    }
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1 : 0.7)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5).delay(1), value: showContent)
                }
                .offset(y: -30)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    circleScale = (geometry.size.width / 100) * 2.5
                    circleOffset = -geometry.size.height / 4
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showContent = true
                }
            }
            
        }
        .transition(.opacity)
    }
}

#Preview {
    AnimatedIntroView(title: "Arrays", sectionNumber: 1) {
        ArrayIntroductionView()
    }
}
