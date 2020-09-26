//
//  YesNoButtonView.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/7/20.
//

import SwiftUI

struct YesNoButtonView: View {
    @Environment(\.theme) var theme
    
    var question: String
    @Binding var answer: Bool?
    
    private var isYesSelected: Bool {
        answer == true
    }
    
    private var isNoSelected: Bool {
        answer == false
    }
    
    var body: some View {
        VStack {
            Text(question)
                .font(.title)
            HStack {
                Button(action: {
                    answer = false
                }) {
                    Image(systemName: isNoSelected ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(theme.white)
                }
                
                Spacer()
                
                Button(action: {
                    answer = true
                }) {
                    Image(systemName: isYesSelected ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(theme.white)
                }
            }
            .padding()
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct YesNoButtonView_Previews: PreviewProvider {
    @State static var answer: Bool? = nil
    
    static var previews: some View {
        YesNoButtonView(
            question: "Do you go to work?",
            answer: $answer
        )
    }
}
