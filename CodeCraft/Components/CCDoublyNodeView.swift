//
//  CCDoublyNodeView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 29/09/24.
//
import SwiftUI

struct CCDoublyNodeView: View {
    let element: Int
    let isHead: Bool
    let isTail: Bool
    
    init(element: Int,
         isHead: Bool = false,
         isTail: Bool = false) {
        self.element = element
        self.isHead = isHead
        self.isTail = isTail
    }
    
    private var headOrTailText: String {
        isHead && isTail ? "Head/Tail" : (isHead ? "Head" : (isTail ? "Tail" : ""))
    }
    
    var body: some View {
        HStack {
            if !isHead {
                Image(systemName: "arrow.backward")
                    .foregroundStyle(.white)
            }
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.lightLavender)
                    .frame(width: 64, height: 64)
                Text("\(element)")
                    .appFont(AppTheme.Fonts.title3)
                Text(headOrTailText)
                    .foregroundStyle(.white)
                    .offset(y: -52)
            }
            if !isTail {
                Image(systemName: "arrow.forward")
                    .foregroundStyle(.white)
            }
        }
    }
}
