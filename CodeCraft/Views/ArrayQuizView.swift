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
                
                HStack(spacing: 16.0) {
                    Button {
                        submitAnswers()
                    } label: {
                        CCPrimaryButtonView(text: "Submit answers")
                    }
                    Button {
                        resetAnswers()
                    } label: {
                        CCSecondaryButtonView(text: "Reset")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ArrayQuizView()
}

