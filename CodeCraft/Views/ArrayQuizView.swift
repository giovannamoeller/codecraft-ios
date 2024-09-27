//
//  ArrayQuizView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct ArrayQuizView: View {
    
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
    @State private var isSubmitted: Bool = false
    @State private var showResult: Bool = false
    @State private var userScore: Int = 0
    
    private func submitAnswers() {
        calculateUserScore()
        withAnimation {
            isSubmitted = true
            showResult = true
        }
    }
    
    private func resetAnswers() {
        withAnimation {
            selectedAnswers = Array(repeating: nil, count: 5)
            isSubmitted = false
            showResult = false
            userScore = 0
        }
    }
    
    private func calculateUserScore() {
        userScore = 0
        for i in 0..<arrayQuestions.count {
            if let selectedAnswer = selectedAnswers[i],
               arrayQuestions[i].correctAnswerIndex == selectedAnswer {
                userScore += 1
            }
        }
    }
    
    var body: some View {
        ZStack {
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
                            CCPrimaryButtonView(text: "Submit answers", displayIcon: false)
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
            .blur(radius: showResult ? 3 : 0)
            
            if showResult {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                QuizResultsModal(
                    correctAnswers: userScore,
                    totalQuestions: arrayQuestions.count,
                    isPresented: $showResult,
                    destination: {
                        SinglyLinkedListIntroductionView()
                    }
                )
                .offset(y: showResult ? 0 : -300)
                .transition(.scale.combined(with: .opacity).combined(with: .offset(y: 1000)))
            }
        }
    }
}

struct QuizResultsModal<Destination: View>: View {
    let correctAnswers: Int
    let totalQuestions: Int
    let destination: Destination
    @Binding var isPresented: Bool
    
        
    init(correctAnswers: Int,
         totalQuestions: Int,
         isPresented: Binding<Bool>,
         @ViewBuilder destination: @escaping () -> Destination) {
        self.correctAnswers = correctAnswers
        self.totalQuestions = totalQuestions
        self._isPresented = isPresented
        self.destination = destination()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz completed!")
                .appFont(AppTheme.Fonts.title)
            
            Text("You got \(correctAnswers) out of \(totalQuestions) questions correct.")
                .appFont(AppTheme.Fonts.bodyRegular)
                .padding(.vertical)
            
            HStack(spacing: 16) {
                
                Button {
                    isPresented = false
                } label: {
                    CCPrimaryButtonView(text: "View my results", displayIcon: false)
                }
                
                NavigationLink {
                    destination
                } label: {
                    CCSecondaryButtonView(text: "Next topic")
                }
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
    ArrayQuizView()
}

