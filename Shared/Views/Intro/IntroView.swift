//
//  ContentView.swift
//  Shared
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct IntroView: View {
    let cloudConfig = CloudConfig()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CloudPainter(offset: 0.0, cloudConfig: cloudConfig)
                Spacer().layoutPriority(1)
                Title("Welcome")
                Spacer().layoutPriority(1)
                IconWrappedAvatar()
                    .padding(.horizontal, 30)
                    .layoutPriority(3)
                Spacer(minLength: 30.0).layoutPriority(1)
                NextButton() {}.layoutPriority(2)
                Subtitle("Let's build your profile!")
                    .padding()
                Spacer(minLength: 50.0).layoutPriority(1)
            }
        }
        .background(defaultTheme.backgroundGradient)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
