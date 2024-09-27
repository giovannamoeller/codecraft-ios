//
//  ArrayQuizView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct ArrayQuizView: View {
    var body: some View {
        QuizView(title: "Array", questions: arrayQuestions) {
            AnimatedSinglyLinkedListIntroView()
        }
    }
}

#Preview {
    ArrayQuizView()
}
