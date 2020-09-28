//
//  Cloud.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct Cloud: View {
    @Environment(\.theme) private var theme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(theme.accentColor)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(theme.white, lineWidth: strokeWidth)
        }
        .frame(width: Cloud.width, height: Cloud.height)
    }
    
    private let cornerRadius: CGFloat = 20.0
    private let strokeWidth: CGFloat = 0.5
    static let width: CGFloat = 240.0
    static let height: CGFloat = 40.0
}

struct Cloud_Previews: PreviewProvider {
    static var previews: some View {
        Cloud()
    }
}
