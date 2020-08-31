//
//  Theme.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

let defaultAnimation = Animation.easeInOut

extension EnvironmentValues {
    var theme: Theme {
        get { self[Theme.self] }
        set { self[Theme.self] = newValue }
    }
}

struct Theme: EnvironmentKey {
    static var defaultValue: Theme = defaultTheme
    
    let backgroundColors: [Color]
    let accentColor: Color
    let highlightColor: Color
    let inactiveWhite: Color
    let white: Color
    let grey: Color
    
    var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .top, endPoint: .bottom)
    }
}

var defaultTheme: Theme {
    let backgroundLight = Color(hex: 0x6F3A88)
    let backgroundDark = Color(hex: 0x3E1A50)
    let accentColor = Color(hex: 0xAA4DAC)
    let highlightColor = Color(hex: 0xB51DCE)
    let grey = Color(hex: 0x929292)
    let white = Color.white
    let inactiveWhite = Color.white.opacity(0.7)
    return Theme(
        backgroundColors: [backgroundLight, backgroundDark],
        accentColor: accentColor,
        highlightColor: highlightColor,
        inactiveWhite: inactiveWhite,
        white: white,
        grey: grey
    )
}

extension Color {
    init(hex: UInt32, opacity: Double = 1.0) {
        let mask = 0x000000FF
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red     = Double(r) / 255.0
        let green   = Double(g) / 255.0
        let blue    = Double(b) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
