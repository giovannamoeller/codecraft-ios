//
//  ArrayIntroductionView.swift
//  CodeCraft
//
//  Created by Giovanna Moeller on 24/09/24.
//

import SwiftUI

struct ArrayIntroductionView: View {
    
    let arrayRealWorldAnalogies = [
        Analogy(icon: "car", title: "Parking Lot", description: "Numbered spaces in a row."),
        Analogy(icon: "book", title: "Bookshelf", description: "Books arranged in order."),
        Analogy(icon: "calendar", title: "Calendar", description: "Days of the month in sequence."),
        Analogy(icon: "tram", title: "Train", description: "A series of connected carriages.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 36.0) {
                ZStack(alignment: .bottomLeading) {
                    Image("arrays-01")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                    
                    Text("Introduction to Arrays")
                        .appFont(AppFont.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("What is an Array?")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("An array is a data structure that stores a collection of elements of the same type in contiguous memory locations. Each element in an array is identified by an index or a key.")
                        .font(.body)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Real-World Analogies")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(arrayRealWorldAnalogies, id: \.title) { analogy in
                        AnalogyRow(analogy: analogy)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("When to use arrays")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "square.and.pencil")
                        
                        Text("When you need quick access to elements by index.")
                    }
                    
                    HStack {
                        Image(systemName: "square.and.pencil")
                        
                        Text("For implementing other data structures like stacks and queues.")
                    }
                    
                    HStack {
                        Image(systemName: "square.and.pencil")
                        
                        Text("When working with sequences of data (e.g., time series).")
                    }
                    
                    HStack {
                        Image(systemName: "square.and.pencil")
                        
                        Text("In scenarios where memory locality is important for performance.")
                    }
                }
                .padding(.horizontal)
                
                Button {
                    //
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                        
                        Text("Learn more")
                            .appFont(AppFont.bodyBold)
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color("DarkGreen"))
                    .cornerRadius(24.0)
                    .frame(maxWidth: .infinity)
                }

            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ArrayIntroductionView()
}
