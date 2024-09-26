//
//  ArrayQuizView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct ArrayQuizView: View {
    
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
    @State private var isSubmitted = false
    
    private func submitAnswers() {
        withAnimation {
            isSubmitted = true
        }
    }
    
    private func resetAnswers() {
        withAnimation {
            selectedAnswers = Array(repeating: nil, count: 5)
            isSubmitted = false
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Array Quiz")
                    .appFont(AppTheme.Fonts.largeTitle)
                    .padding()
                
                ForEach(0..<arrayQuestions.count, id: \.self) { index in
                    CCQuestionView(question: arrayQuestions[index], isSubmitted: $isSubmitted, selectedAnswer: $selectedAnswers[index])
                        .padding(.bottom)
                }
                
                HStack {
                    Button {
                        submitAnswers()
                    } label: {
                        Text("Submit answers")
                            .appFont(AppTheme.Fonts.bodyBold)
                    }
                    .frame(minWidth: 148)
                    .padding()
                    .background(AppTheme.Colors.darkGreen)
                    .foregroundStyle(.white)
                    .appFont(AppTheme.Fonts.title3)
                    .cornerRadius(28.0)

                    Button {
                        resetAnswers()
                    } label: {
                        Text("Reset")
                            .appFont(AppTheme.Fonts.bodyBold)
                            .foregroundStyle(AppTheme.Colors.mediumBrown)
                    }
                    .frame(minWidth: 148)
                    .padding()
                    .foregroundStyle(.black)
                    .background(Color(AppTheme.Colors.lightBrown))
                    .cornerRadius(28.0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 28.0)
                            .stroke(Color(AppTheme.Colors.mediumBrown), lineWidth: 1.0)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ArrayQuizView()
}

