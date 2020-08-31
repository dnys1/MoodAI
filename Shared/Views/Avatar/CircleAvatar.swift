//
//  CircleAvatar.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct CircleAvatar: View {
    @Environment(\.theme) private var theme
    let percentComplete: Double
    
    init(percentComplete: Double = 1) {
        self.percentComplete = percentComplete
    }
    
    var body: some View {
        ZStack {
            Circle().fill(theme.white)
            AvatarView()
                .scaleEffect(0.6)
                .foregroundColor(theme.grey)
            ProgressBorder(complete: percentComplete)
        }
        .progressViewStyle(CircularProgressViewStyle())
    }
}

struct CircleAvatar_Previews: PreviewProvider {
    static var previews: some View {
        CircleAvatar(percentComplete: 0.5)
            .padding()
    }
}
