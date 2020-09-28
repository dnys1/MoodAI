//
//  IntroIconWrappedView.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct IconWrappedAvatar: View {
    @ObservedObject var keyboardResponder = KeyboardResponder.shared
    @EnvironmentObject var user: User
    
    let stage: IntroStage
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
        .frame(minHeight: 250, maxHeight: keyboardResponder.isShowing ? 250 : 350)
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            avatar(for: size)
            if stage == .step(.avatar) {
                buttons(for: size)
            }
            icons(for: size)
        }
    }
    
    private var allIcons: [Icon] {
        IntroStep.allCases.map { Icon(data: $0.icon) }
    }
    
    private func isVisible(iconIndex: Int) -> Bool {
        switch stage {
        case .loading:
            return false
        case .start:
            return true
        case .step(let step):
            return iconIndex <= IntroStep.allCases.firstIndex(of: step)!
        case .finish:
            return true
        }
    }
    
    private func isHighlighted(iconIndex: Int) -> Bool {
        switch stage {
        case .loading:
            return false
        case .start:
            return false
        case .step(let step):
            return iconIndex < IntroStep.allCases.firstIndex(of: step)!
        case .finish:
            return true
        }
    }
    
    private var percentComplete: Double {
        switch stage {
        case .loading:
            fallthrough
        case .start:
            return 0.0
        case .step(let step):
            let index = IntroStep.allCases.firstIndex(of: step)!
            return Double(index) / Double(IntroStep.allCases.count)
        case .finish:
            return 1.0
        }
    }
    
    private func icons(for size: CGSize) -> some View {
        let smallestLength = min(size.width, size.height)
        let iconSize = iconSizeRatio * smallestLength / 2
        let avatarSize = avatarSizeRatio * smallestLength
        let paddingSize = paddingSizeRatio * smallestLength / 2
        let numIcons = allIcons.count
        let dAngle = 360.0 / Double(numIcons)
        
        var positions: [CGPoint] = []
        
        // Drawing starts at r = 0 radians (y = 0)
        let startDegrees = -90.0
        
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        for iconIndex in 0..<numIcons {
            let degrees = Double(iconIndex) * dAngle
            let angle = Angle(degrees: startDegrees + degrees)
            let radians = CGFloat(angle.radians)
            let r: CGFloat = (avatarSize / 2) + paddingSize + iconSize / 2
            let x = center.x + r * cos(radians)
            let y = center.y + r * sin(radians)
            
            positions.append(CGPoint(x: x, y: y))
        }
        
        return ForEach(0..<numIcons) { iconIndex in
            let icon = allIcons[iconIndex]
            let position = positions[iconIndex]
            let visible = isVisible(iconIndex: iconIndex)
            let highlighted = isHighlighted(iconIndex: iconIndex)
            IconView(icon: icon, size: iconSize, visible: visible, highlighted: highlighted)
                .position(x: position.x, y: position.y)
        }
    }
    
    private func buttons(for size: CGSize) -> some View {
        let smallestLength = min(size.width, size.height)
        let iconSize = iconSizeRatio * smallestLength / 2
        let avatarSize = avatarSizeRatio * smallestLength
        let paddingSize = paddingSizeRatio * smallestLength / 2
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let radians = CGFloat(Angle(degrees: 0).radians)
        let r: CGFloat = (avatarSize / 2) + paddingSize + iconSize / 2
        let leftX = center.x - r * cos(radians)
        let rightX = center.x + r * cos(radians)
        let y = center.y + r * sin(radians)
        
        let leftPos = CGPoint(x: leftX, y: y)
        let rightPos = CGPoint(x: rightX, y: y)
        return AvatarButtons(leftPos: leftPos, rightPos: rightPos, size: iconSize)
    }
    
    private func avatar(for size: CGSize) -> some View {
        let smallestLength = min(size.width, size.height)
        let avatarSize = avatarSizeRatio * smallestLength
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        return CircleAvatar(percentComplete: percentComplete, stage: stage)
            .frame(width: avatarSize, height: avatarSize)
            .position(x: center.x, y: center.y)
    }
    
    private let iconSizeRatio: CGFloat = 0.3
    private let avatarSizeRatio: CGFloat = 0.55
    private var paddingSizeRatio: CGFloat { 1.0 - iconSizeRatio - avatarSizeRatio }
}

struct IntroIconWrappedView_Previews: PreviewProvider {
    static var previews: some View {
        IconWrappedAvatar(stage: .start)
    }
}
