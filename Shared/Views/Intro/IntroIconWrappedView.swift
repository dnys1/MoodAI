//
//  IntroIconWrappedView.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct IntroIconWrappedView: View {
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
        .frame(minHeight: 250, maxHeight: 500)
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            avatar(for: size)
            icons(for: size)
        }
    }
    
    private var allIcons: [Icon] {
        IconGroup.allCases.map { Icon(iconGroup: $0) }
    }
    
    private func icons(for size: CGSize) -> some View {
        print("icons received size: \(size)")
        let smallestLength = min(size.width, size.height)
        let iconSize = iconSizeRatio * smallestLength / 2
        let avatarSize = avatarSizeRatio * smallestLength
        let paddingSize = paddingSizeRatio * smallestLength / 2
        let numIcons = IconGroup.allCases.count
        let dAngle = 360.0 / Double(numIcons)
        
        var positions: [CGPoint] = []
        
        // Drawing starts at r = 0 radians (y = 0)
        let startDegrees = -90.0
        
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        print("Center: \(center)")
        
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
            IconView(icon: icon, size: iconSize)
                .position(x: position.x, y: position.y)
        }
    }
    
    private func avatar(for size: CGSize) -> some View {
        print("circle received size: \(size)")
        let smallestLength = min(size.width, size.height)
        let avatarSize = avatarSizeRatio * smallestLength
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        return CircleAvatar(percentComplete: 0.5)
            .frame(width: avatarSize, height: avatarSize)
            .position(x: center.x, y: center.y)
    }
    
    private let iconSizeRatio: CGFloat = 0.3
    private let avatarSizeRatio: CGFloat = 0.55
    private var paddingSizeRatio: CGFloat { 1.0 - iconSizeRatio - avatarSizeRatio }
}

struct IntroIconWrappedView_Previews: PreviewProvider {
    static var previews: some View {
        IntroIconWrappedView()
    }
}
