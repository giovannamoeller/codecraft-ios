//
//  CCQuestionView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct CCQuestionView: View {
    
    let question: Question
    
    @Binding var isSubmitted: Bool
    @Binding var selectedAnswer: Int?
    
    private func backgroundColor(for index: Int) -> Color {
        if isSubmitted {
            if index == question.correctAnswerIndex {
                return .green.opacity(0.3)
            } else if index == selectedAnswer && index != question.correctAnswerIndex {
                return .red.opacity(0.3)
            }
        }
        return .white
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(question.title)
                .appFont(AppTheme.Fonts.headline)
                .padding(.bottom, 5)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(0..<4) { index in
                    Button(action: {
                        if !isSubmitted {
                            withAnimation {
                                selectedAnswer = index
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: selectedAnswer == index ? "checkmark.square.fill" : "square")
                                .foregroundStyle(isSubmitted && index == selectedAnswer && index != question.correctAnswerIndex ? Color.red.opacity(0.5) : .black)
                                .foregroundStyle(selectedAnswer == index ? AppTheme.Colors.darkGreen : .black)
                            Text(question.options[index])
                                .appFont(selectedAnswer == index ? AppTheme.Fonts.bodyBold : AppTheme.Fonts.bodyRegular)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(backgroundColor(for: index))
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .background(AppTheme.Colors.lightBrown)
        .cornerRadius(12)
    }
}

#Preview {
    CCQuestionView(question: arrayQuestions[0], isSubmitted: .constant(true), selectedAnswer: .constant(1))
}
