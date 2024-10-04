//
//  InteractiveHeaderView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 04/10/24.
//

import SwiftUI

struct InteractiveHeaderView: View {
    var text: String
    var data: [GridData]
    var guideline: String
    
    var body: some View {
        VStack {
            ResponsiveTextView(text: text, style: .title)
                .padding([.top, .horizontal])
            
            CCFlexibleGridView(data: data)
                .padding(.horizontal)
            
            ResponsiveTextView(text: guideline, style: .bodyRegular)
                .padding(.horizontal)
        }
    }
}

#Preview {
    InteractiveHeaderView(text: "Bubble sort", data: UsageExample.bubbleSort, guideline: "Press 'start sorting'")
}
