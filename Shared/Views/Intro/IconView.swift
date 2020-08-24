//
//  IconView.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct IconData {
    let unfilled: String
    let filled: String
}

struct Icon: Identifiable {
    let id = UUID()
    let iconGroup: IconGroup
    let filled: Bool
    
    init(iconGroup: IconGroup, filled: Bool = false) {
        self.iconGroup = iconGroup
        self.filled = filled
    }
}

enum IconGroup: CaseIterable {
    case avatar
    case healthkit
    case personal
    case dailylife
    case commute
    case sleep
    case activities
    case notifications
    
    var icon: IconData {
        switch self {
        case .avatar:
            return IconData(unfilled: "face.smiling", filled: "face.smiling.fill")
        case .healthkit:
            return IconData(unfilled: "staroflife", filled: "staroflife.fill")
        case .personal:
            return IconData(unfilled: "heart", filled: "heart.fill")
        case .dailylife:
            return IconData(unfilled: "building", filled: "building.fill")
        case .commute:
            return IconData(unfilled: "car", filled: "car.fill")
        case .sleep:
            return IconData(unfilled: "bed.double", filled: "bed.double.fill")
        case .activities:
            return IconData(unfilled: "figure.walk", filled: "figure.walk")
        case .notifications:
            return IconData(unfilled: "exclamationmark.bubble", filled: "exclamationmark.bubble.fill")
        }
    }
    
    var filled: String { icon.filled }
    var unfilled: String { icon.unfilled }
}

struct IconView: View {
    let icon: Icon
    let size: CGFloat
    let color: Color
    
    init(icon: Icon, size: CGFloat = defaultSize, color: Color = defaultColor) {
        self.icon = icon
        self.size = size
        self.color = color
    }
    
    private var systemName: String {
        if icon.filled {
            return icon.iconGroup.filled
        } else {
            return icon.iconGroup.unfilled
        }
    }
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .foregroundColor(color)
            .scaledToFit()
            .frame(width: size, height: size, alignment: .center)
    }
    
    private static let defaultSize: CGFloat = 50.0
    private static let defaultColor = defaultTheme.grey
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(icon: Icon(iconGroup: .avatar))
    }
}
