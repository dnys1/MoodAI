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
            VStack(alignment: .center, spacing: 0) {
                CloudPainter(offset: 0.0, cloudConfig: cloudConfig)
                Spacer().layoutPriority(1)
                Text("Welcome")
                    .font(.system(size: 40, weight: Font.Weight.medium, design: .default))
                    .foregroundColor(defaultTheme.white)
                Spacer().layoutPriority(1)
                IntroIconWrappedView()
                    .padding(.horizontal, 30)
                    .layoutPriority(3)
                Spacer(minLength: 30.0).layoutPriority(1)
                NextButton() {}
                    .padding(.bottom, 30)
                Spacer().layoutPriority(1)
                Text("Let's build your profile!")
                    .font(.title)
                    .foregroundColor(defaultTheme.white)
                Spacer(minLength: 30.0).layoutPriority(1)
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
