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
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    private let cloudConfig = CloudConfig(width: Double(UIScreen.screenWidth * 5), height: Double(UIScreen.screenHeight * 0.08))
    
    @EnvironmentObject var user: User
    @EnvironmentObject var progress: IntroProgress
    @Environment(\.managedObjectContext) private var viewContext
    
    private var title: String {
        switch progress.stage {
        case .loading:
            return ""
        case .start:
            return "Welcome"
        case .step(let step):
            return step.title
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
    
    private var subtitleFont: Font {
        var font = Font.largeTitle
        #if os(iOS)
        if let sizeClass = horizontalSizeClass,
           sizeClass == .compact {
            font = Font.title
        }
        #endif
        return font
    }
    
    @State private var commute: Bool? = nil
    
    @ViewBuilder
    private var secondary: some View {
        switch progress.stage {
        case .start:
            Text("Let's build your profile!")
                .foregroundColor(theme.white)
                .font(subtitleFont)
        case .step(let step):
            switch step {
            case .healthkit:
                ImportHealthData()
            case .personal:
                NameView()
            case .commute:
                YesNoButtonView(question: "Do you commute?", answer: $commute)
            case .notifications:
                NotificationsView()
            default:
                ImportHealthData()
            }
        case .finish:
            Text("Get started!")
                .foregroundColor(theme.white)
                .font(subtitleFont)
        default:
            ImportHealthData()
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
            return CGFloat(currentIndex) / CGFloat(count) * cloudConfig.width * 0.5
        case .finish:
            return cloudConfig.width + Cloud.width / 2
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
                progress.complete = true
            }
            progress.stage = nextStep
        }
        progress.save()
    }
    
    var body: some View {
        VStack {
            CloudPainter(offset: offset, cloudConfig: cloudConfig)
            Spacer().layoutPriority(1)
            Title(title)
            Spacer(minLength: 30).layoutPriority(1)
            primary
                .layoutPriority(3)
            secondary
                .frame(height: 125)
                .padding(.vertical, 20)
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(3)
            if progress.stage != .loading {
                Spacer().layoutPriority(1)
                NextButton() {
                    moveToNextStep()
                }.layoutPriority(2)
                Spacer().layoutPriority(1)
                Text("You can always update your preferences later in Settings.")
                    .frame(height: 50)
                    .lineLimit(2)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(theme.white)
                    .padding(.horizontal, 75)
                Spacer(minLength: 35).layoutPriority(1)
            }
        }
        .background(theme.backgroundGradient)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let user = User.current(for: context)
        let progress = IntroProgress.current(for: context)
        IntroView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(user)
            .environmentObject(progress)
    }
}
