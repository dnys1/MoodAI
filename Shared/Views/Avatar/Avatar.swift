//
//  Avatar.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/23/20.
//

import SwiftUI

enum AvatarCharacter {
    case man
    case woman
    case none
}

struct Avatar: View {
    let avatar: AvatarCharacter = .none
    
    var body: some View {
        switch avatar {
        case .none:
            fallthrough
        default:
            return Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
        }
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}
