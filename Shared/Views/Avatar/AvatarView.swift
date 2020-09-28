//
//  AvatarView.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import SwiftUI

struct AvatarView: View {
    @EnvironmentObject<User> private var user

    @State var offset: CGFloat = 0
    
    @ViewBuilder
    private var avatar: some View {
        switch user.avatar {
        case .none:
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 5)
        case .man:
            Image("003-business man")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 5)
                .foregroundColor(.blue)
        case .woman:
            Image("021-trainers")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 5)
                .foregroundColor(.red)
        }
    }
    
    var body: some View {
        avatar
            .transition(.opacity) // TODO
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
