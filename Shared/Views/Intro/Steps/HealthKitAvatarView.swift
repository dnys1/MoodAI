//
//  HealthKitAvatarView.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/3/20.
//

import SwiftUI

struct HealthKitAvatarView: View {
    var body: some View {
        Image("Icon - Apple Health")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 5)
    }
}

struct HealthKitAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitAvatarView()
    }
}
