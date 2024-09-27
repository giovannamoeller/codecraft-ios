//
//  ArrayQuizView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 27/09/24.
//

import SwiftUI

struct ArrayQuizView: View {
    var body: some View {
        QuizView(questions: arrayQuestions) {
            SinglyLinkedListIntroductionView()
        }
    }
}

#Preview {
    ArrayQuizView()
}
