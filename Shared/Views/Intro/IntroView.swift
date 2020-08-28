//
//  ContentView.swift
//  Shared
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

enum Screens: Int, CaseIterable {
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
}

enum IntroStep {
    case start
    case step(_ screen: Screens)
    case finish
}

struct IntroView: View {
    let cloudConfig = CloudConfig()
    @State var currentScreen: IntroStep
    
    var title: String {
        switch currentScreen {
        case .start:
            return "Welcome"
        case .step(_):
            return "Default"
        case .finish:
            return "Complete"
        }
    }
    
    var subtitle: String {
        switch currentScreen {
        case .start:
            return "Let's build your profile!"
        case .step(_):
            return "Subtitle"
        default:
            return "Get started!"
        }
    }
    
    var content: some View {
        var primary = IconWrappedAvatar(step: currentScreen)
            .padding(.horizontal, 30)
        var secondary = EmptyView()
        switch currentScreen {
        case .start:
            fallthrough
        default:
            break
        }
        return VStack(alignment: .leading) {
            primary
            secondary
        }
    }
    
    var offset: CGFloat {
        switch currentScreen {
        case .start:
            return 0
        case .step(let screen):
            let count = Screens.allCases.count
            let currentIndex = Screens.allCases.firstIndex(of: screen)!
            return CGFloat(currentIndex) / CGFloat(count) * cloudConfig.width
        case .finish:
            return cloudConfig.width
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CloudPainter(offset: offset, cloudConfig: cloudConfig)
                Spacer().layoutPriority(1)
                Title(title)
                Spacer().layoutPriority(1)
                content.layoutPriority(3)
                Spacer(minLength: 30.0).layoutPriority(1)
                NextButton() {
                    withAnimation {
                        switch currentScreen {
                        case .start:
                            currentScreen = .step(Screens.allCases.first!)
                        case .step(let screen):
                            let nextScreenIndex = screen.rawValue + 1
                            let nextScreen = Screens(rawValue: nextScreenIndex)
                            if let nextScreen = nextScreen {
                                currentScreen = .step(nextScreen)
                            } else {
                                currentScreen = .finish
                            }
                        case .finish:
                            break // TODO
                        }
                    }
                }.layoutPriority(2)
                Subtitle(subtitle)
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
        IntroView(currentScreen: .start)
    }
}
