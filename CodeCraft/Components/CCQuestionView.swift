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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private func selectAnswer(_ index: Int) {
        guard !isSubmitted else { return }
        withAnimation {
            selectedAnswer = index
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            ResponsiveTextView(text: question.title,
                               style: .bodyBold)
            .padding(.bottom, 5)
            
            OptionLayout(horizontalSizeClass: horizontalSizeClass) {
                ForEach(0..<question.options.count, id: \.self) { index in
                    OptionButton(
                        index: index,
                        option: question.options[index],
                        isSelected: selectedAnswer == index,
                        isSubmitted: isSubmitted,
                        isCorrect: index == question.correctAnswerIndex,
                        action: { selectAnswer(index) }
                    )
                }
            }
        }
        .padding()
        .background(AppTheme.Colors.lightLavender)
        .cornerRadius(12)
    }
}

struct OptionLayout<Content: View>: View {
    let horizontalSizeClass: UserInterfaceSizeClass?
    let content: Content
    
    init(horizontalSizeClass: UserInterfaceSizeClass?, @ViewBuilder content: () -> Content) {
        self.horizontalSizeClass = horizontalSizeClass
        self.content = content()
    }
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack { content }
        } else {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                content
            }
        }
    }
}

struct OptionButton: View {
    let index: Int
    let option: String
    let isSelected: Bool
    let isSubmitted: Bool
    let isCorrect: Bool
    let action: () -> Void
    
    private var backgroundColor: Color {
        if isSubmitted {
            if isCorrect {
                return .green.opacity(0.3)
            } else if isSelected {
                return .red.opacity(0.3)
            }
        }
        return .white
    }
    
    private var foregroundColor: Color {
        if isSubmitted && isSelected && !isCorrect {
            return Color.red.opacity(0.5)
        } else if isSelected {
            return AppTheme.Colors.indigo
        }
        return .black
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundStyle(foregroundColor)
                ResponsiveTextView(text: option, style: isSelected ? .bodyBold : .bodyRegular)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CCQuestionView(question: arrayQuestions[0], isSubmitted: .constant(true), selectedAnswer: .constant(1))
}
