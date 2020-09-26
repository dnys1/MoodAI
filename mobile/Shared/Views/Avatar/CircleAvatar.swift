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
    let stage: IntroStage
    
    init(percentComplete: Double = 1, stage: IntroStage) {
        self.percentComplete = percentComplete
        self.stage = stage
    }
    
    var body: some View {
        ZStack {
            Circle().fill(theme.white)
            if stage == .step(.healthkit) {
                HealthKitAvatarView()
                    .scaleEffect(0.6)
                    .foregroundColor(theme.grey)
                    .shadow(radius: 5)
            } else {
                AvatarView()
                    .scaleEffect(0.6)
                    .foregroundColor(theme.grey)
            }
            ProgressBorder(complete: percentComplete)
        }
        .progressViewStyle(CircularProgressViewStyle())
    }
}

struct CircleAvatar_Previews: PreviewProvider {
    static var previews: some View {
        CircleAvatar(percentComplete: 0.5, stage: .start)
            .padding()
    }
}
