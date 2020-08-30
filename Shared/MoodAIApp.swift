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
        WindowGroup {
            IntroView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
