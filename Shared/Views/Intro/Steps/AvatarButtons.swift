//
//  AvatarButtons.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import SwiftUI

private enum AvatarButton: Identifiable, CaseIterable {
    var id: AvatarButton { self }
    
    case left
    case right
    
    var icon: String {
        switch self {
        case .left:
            return "chevron.left"
        case .right:
            return "chevron.right"
        }
    }
}

struct AvatarButtons: View {
    @Environment(\.theme) private var theme
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    
    let leftPos: CGPoint
    let rightPos: CGPoint
    let size: CGFloat
    
    var currentIndex: Int {
        let currentAvatar = user.avatar
        let currentAvatarIndex = Avatar.allCases.firstIndex(of: currentAvatar)!
        return currentAvatarIndex
    }
    
    var numAvatars: Int { Avatar.allCases.count }
    var leftDisabled: Bool { currentIndex == 0 }
    var rightDisabled: Bool { currentIndex == numAvatars - 1 }
    
    var body: some View {
        HStack {
            Button(action: {
                let nextIndex = max(currentIndex - 1, 0)
                withAnimation {
                    user.avatar = Avatar.allCases[nextIndex]
                }
                user.save(context: viewContext)
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundColor(leftDisabled ? theme.grey : theme.white)
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
            .disabled(leftDisabled)
            
            Spacer()
            
            Button(action: {
                let nextIndex = min(currentIndex + 1, numAvatars - 1)
                withAnimation {
                    user.avatar = Avatar.allCases[nextIndex]
                }
                user.save(context: viewContext)
            }) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .foregroundColor(rightDisabled ? theme.grey : theme.white)
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
            .disabled(rightDisabled)
        }
    }
}

struct AvatarButtons_Previews: PreviewProvider {
    static var previews: some View {
        AvatarButtons(leftPos: CGPoint(x: 60, y: 0), rightPos: CGPoint(x: 0, y: 0), size: 50)
            .frame(width: 200, height: 200)
            .offset(x: 100)
    }
}
