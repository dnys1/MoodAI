//
//  ContentView.swift
//  Shared
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI
import CoreData

struct IntroView: View {
    @Environment(\.theme) private var theme
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    private let cloudConfig = CloudConfig()
    
    @State private var progress = IntroProgress.loading() {
        didSet {
            if progress.complete {
                print("COMPLETE!")
            }
        }
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private var title: String {
        switch progress.stage {
        case .loading:
            return ""
        case .start:
            return "Welcome"
        case .step(_):
            return "Default"
        case .finish:
            return "Complete"
        }
    }
    
    private var subtitle: String {
        switch progress.stage {
        case .loading:
            return ""
        case .start:
            return "Let's build your profile!"
        case .step(_):
            return "Subtitle"
        case .finish:
            return "Get started!"
        }
    }
    
    @ViewBuilder
    private var primary: some View {
        switch progress.stage {
        case .loading:
            ProgressView()
        default:
            IconWrappedAvatar(stage: progress.stage)
                .padding(.horizontal, 30)
                .environmentObject(User.current(for: viewContext))
        }
    }
    
    @ViewBuilder
    private var secondary: some View {
        switch progress.stage {
        default:
            EmptyView()
        }
    }
    
    private var offset: CGFloat {
        switch progress.stage {
        case .loading:
            fallthrough
        case .start:
            return 0
        case .step(let screen):
            let count = IntroStep.allCases.count
            let currentIndex = IntroStep.allCases.firstIndex(of: screen)!
            return CGFloat(currentIndex) / CGFloat(count) * cloudConfig.width
        case .finish:
            return cloudConfig.width
        }
    }
    
    private func moveToNextStep() {
        feedbackGenerator.notificationOccurred(.success)
        withAnimation {
            var nextStep: IntroStage
            switch progress.stage {
            case .loading:
                nextStep = .start
            case .start:
                nextStep = .step(IntroStep.allCases.first!)
            case .step(let screen):
                let nextScreenIndex = screen.rawValue + 1
                let nextScreen = IntroStep(rawValue: nextScreenIndex)
                if let nextScreen = nextScreen {
                    nextStep = .step(nextScreen)
                } else {
                    nextStep = .finish
                }
            case .finish:
                nextStep = .finish
                progress.setComplete()
            }
            progress.setStep(nextStep)
        }
        progress.save(context: viewContext)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CloudPainter(offset: offset, cloudConfig: cloudConfig)
                Spacer().layoutPriority(1)
                Title(title)
                Spacer().layoutPriority(1)
                VStack(alignment: .leading) {
                    primary
                    secondary
                }.layoutPriority(3)
                if progress.stage != .loading {
                    Spacer(minLength: 30.0).layoutPriority(1)
                    NextButton() {
                        moveToNextStep()
                    }.layoutPriority(2)
                    Subtitle(subtitle)
                        .padding()
                    Spacer(minLength: 50.0).layoutPriority(1)
                }
            }
        }
        .background(theme.backgroundGradient)
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear() { progress = IntroProgress.load(context: viewContext) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
