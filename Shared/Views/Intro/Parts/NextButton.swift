//
//  NextButton.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/23/20.
//

import SwiftUI

struct NextButton: View {
    @Environment(\.theme) private var theme
    
    let action: () -> Void
    let active: Bool
    
    fileprivate init() {
        self.init() {}
    }
    
    init(action: @escaping () -> Void) {
        self.action = action
        self.active = true
    }
    
    init(active: Bool, action: @escaping () -> Void) {
        self.active = active
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "arrow.right.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(active ? theme.white : theme.inactiveWhite)
                .frame(minHeight: 60, idealHeight: 100, maxHeight: 100)
        })
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton()
    }
}
