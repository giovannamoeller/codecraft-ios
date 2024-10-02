//
//  String+.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 02/10/24.
//

import Foundation

extension String: RandomElementGeneratable {
    static func getRandomElement() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String(letters.randomElement()!)
    }
}
