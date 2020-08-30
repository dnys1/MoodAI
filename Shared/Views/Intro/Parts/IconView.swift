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
    let data: IconData
    let filled: Bool
    
    init(data: IconData, filled: Bool = false) {
        self.data = data
        self.filled = filled
    }
}

struct IconView: View {
    let icon: Icon
    let size: CGFloat
    let visible: Bool
    let highlighted: Bool
    
    init(icon: Icon, size: CGFloat = defaultSize, visible: Bool = true, highlighted: Bool = false) {
        self.icon = icon
        self.size = size
        self.visible = visible
        self.highlighted = highlighted
    }
    
    private var systemName: String {
        if icon.filled {
            return icon.data.filled
        } else {
            return icon.data.unfilled
        }
    }
    
    private var color: Color {
        if highlighted {
            return defaultTheme.white
        } else {
            return defaultTheme.grey
        }
    }
    
    var body: some View {
        if visible {
            Image(systemName: systemName)
                .resizable()
                .foregroundColor(color)
                .scaledToFit()
                .frame(width: size, height: size, alignment: .center)
        }
    }
    
    private static let defaultSize: CGFloat = 50.0
    private static let defaultColor = defaultTheme.grey
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(icon: Icon(data: IntroStep.avatar.icon))
    }
}
