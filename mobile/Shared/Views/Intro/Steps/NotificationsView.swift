//
//  NotificationsView.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/5/20.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.theme) private var theme
    
    var body: some View {
        Button(action: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Error requesting notification priveleges \(error.localizedDescription)")
                }
                
                if granted {
                    print("Granted!")
                } else {
                    print("Not granted!")
                }
            }
        }) {
            Text("Enable Notifications")
                .font(.title2)
        }
        .foregroundColor(theme.white)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
