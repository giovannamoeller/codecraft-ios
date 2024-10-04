//
//  String+.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 25/09/24.
//

import SwiftUI

extension String {
    func capitalizedFirst() -> String {
        let mirror = Mirror(reflecting: self)
        guard let key = mirror.children.first?.value as? String else {
            return self // Return original if we can't extract the key
        }
        
        let capitalizedKey = key.prefix(1).uppercased() + key.dropFirst()
        return String(capitalizedKey)
    }
}
