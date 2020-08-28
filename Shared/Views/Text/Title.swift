//
//  Title.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/24/20.
//

import SwiftUI

struct Title: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 40, weight: .medium))
            .foregroundColor(defaultTheme.white)
            .animation(defaultAnimation)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
