//
//  QuizView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//

import SwiftUI

struct QuizView<Destination: View>: View {
    
    let title: String
    let questions: [Question]
    let destination: () -> Destination
    
    @State private var selectedAnswers: [Int?] = Array(repeating: nil, count: 5)
    @State private var isSubmitted: Bool = false
    @State private var showResult: Bool = false
    @State private var userScore: Int = 0
    @State private var showMissingAnswerAlert: Bool = false
    
    init(title: String,
         questions: [Question],
         @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.questions = questions
        self.destination = destination
    }
    
    private func submitAnswers() {
        checkForMissingAnswers()
        guard !showMissingAnswerAlert else { return }
        
        calculateUserScore()
        withAnimation {
            isSubmitted = true
            showResult = true
        }
    }
    
    private func checkForMissingAnswers() {
        withAnimation {
            showMissingAnswerAlert = selectedAnswers.contains(nil)
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
        for i in 0..<questions.count {
            if let selectedAnswer = selectedAnswers[i],
               questions[i].correctAnswerIndex == selectedAnswer {
                userScore += 1
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16.0) {
                    ResponsiveTextView(text: "\(title) Quiz", style: .title, alignment: .center)
                    
                    ForEach(0..<questions.count, id: \.self) { index in
                        QuestionView(question: questions[index], isSubmitted: $isSubmitted, selectedAnswer: $selectedAnswers[index])
                            .padding(.bottom)
                    }
                    
                    HStack(spacing: 16.0) {
                        Button {
                            submitAnswers()
                        } label: {
                            PrimaryButtonView(text: "Submit answers", displayIcon: false)
                        }
                        Button {
                            resetAnswers()
                        } label: {
                            SecondaryButtonView(text: "Reset")
                        }
                    }
                }
                .padding()
            }
            .blur(radius: showResult || showMissingAnswerAlert ? 3 : 0)
            
            if showMissingAnswerAlert {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                AlertView(title: "Oops!",
                            message: "You need to answer all questions in order to proceed.",
                            buttonTitle: "Go back to quiz",
                            isPresented: $showMissingAnswerAlert)
                .transition(.scale.combined(with: .opacity).combined(with: .offset(y: 1000)))
            }
            
            if showResult {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                QuizResultsModalView(
                    correctAnswers: userScore,
                    totalQuestions: questions.count,
                    isPresented: $showResult,
                    destination: destination
                )
                .transition(.scale.combined(with: .opacity).combined(with: .offset(y: 1000)))
            }
        }
    }
}

struct QuizResultsModalView<Destination: View>: View {
    let correctAnswers: Int
    let totalQuestions: Int
    let destination: () -> Destination
    @Binding var isPresented: Bool
    
    
    init(correctAnswers: Int,
         totalQuestions: Int,
         isPresented: Binding<Bool>,
         @ViewBuilder destination: @escaping () -> Destination) {
        self.correctAnswers = correctAnswers
        self.totalQuestions = totalQuestions
        self._isPresented = isPresented
        self.destination = destination
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ResponsiveTextView(text: "Quiz completed!", style: .title, alignment: .center)
            
            ResponsiveTextView(text: "You got \(correctAnswers) out of \(totalQuestions) questions correct.", style: .bodyRegular, alignment: .center)
            
            HStack(spacing: 16) {
                Button {
                    isPresented = false
                } label: {
                    PrimaryButtonView(text: "View my results", displayIcon: false)
                }
                                
                NavigationLink {
                    destination()
                } label: {
                    SecondaryButtonView(text: "Next topic")
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
    QuizView(title: "Array", questions: arrayQuestions) {
        SinglyLinkedListIntroductionView()
    }
}

