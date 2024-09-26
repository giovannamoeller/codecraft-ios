//
//  Code.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import Foundation

enum Code {
    static let arrayCodeSnippet: [CodeLanguage: String] = [
        .python: """
        # Python array example
        fruits = ["apple", "banana", "cherry"]
        print(fruits[0])  # Output: apple
        fruits.append("date")
        print(len(fruits))  # Output: 4
        """,
        .java: """
        // Java array example
        String[] fruits = {"apple", "banana", "cherry"};
        System.out.println(fruits[0]);  // Output: apple
        fruits = Arrays.copyOf(fruits, fruits.length + 1);
        fruits[fruits.length - 1] = "date";
        System.out.println(fruits.length);  // Output: 4
        """,
        .swift: """
        // Swift array example
        var fruits = ["apple", "banana", "cherry"]
        print(fruits[0])  // Output: apple
        fruits.append("date")
        print(fruits.count)  // Output: 4
        """,
        .cPlusPlus: """
        // C++ array example
        std::vector<std::string> fruits = {"apple", "banana", "cherry"};
        std::cout << fruits[0] << std::endl;  // Output: apple
        fruits.push_back("date");
        std::cout << fruits.size() << std::endl;  // Output: 4
        """
    ]
}
