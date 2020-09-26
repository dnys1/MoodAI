//
//  MoodAIApp.swift
//  Shared
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

@main
struct MoodAIApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        let context = persistenceController.container.viewContext
        let user = User.current(for: context)
        let progress = IntroProgress.current(for: context)
        WindowGroup {
            IntroView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(user)
                .environmentObject(progress)
        }
    }
}
