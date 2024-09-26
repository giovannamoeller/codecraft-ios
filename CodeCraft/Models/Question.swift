//
//  Question.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 26/09/24.
//


struct Question {
    let title: String
    let options: [String]
    let correctAnswerIndex: Int
}

// Array Questions

let arrayQuestions = [
    Question(title: "What is the time complexity of accessing an element in an array by its index?",
             options: ["O(1)", "O(n)", "O(log n)", "O(n^2)"],
             correctAnswerIndex: 0),
    Question(title: "Which operation is typically slower in a dynamic array?",
             options: ["Appending an element", "Accessing an element", "Removing the last element", "Inserting at the beginning"],
             correctAnswerIndex: 3),
    Question(title: "What happens when you try to access an array index that is out of bounds?",
             options: ["It returns nil", "It wraps around to the beginning", "It causes a runtime error", "It returns a default value"],
             correctAnswerIndex: 2),
    Question(title: "In most programming languages, array indices start at:",
             options: ["1", "0", "-1", "It depends on the language"],
             correctAnswerIndex: 1),
    Question(title: "Which of these is NOT a common operation for arrays?",
             options: ["Sorting", "Reversing", "Splitting", "Linking"],
             correctAnswerIndex: 3)
]
