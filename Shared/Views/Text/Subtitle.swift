//
//  Subtitle.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/24/20.
//

import SwiftUI

struct Subtitle: View {
    let subtitle: String
    
    init(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    var body: some View {
        Text(subtitle)
            .font(.title)
            .foregroundColor(defaultTheme.white)
    }
}

struct Subtitle_Previews: PreviewProvider {
    static var previews: some View {
        Subtitle("Hello, world!")
    }
}
