//
//  IntroScreen.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import Foundation

enum IntroStep: Int, CaseIterable {
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
    
    var title: String {
        switch self {
        case .avatar:
            return "Avatar"
        case .healthkit:
            return "Apple Health"
        case .personal:
            return "Personal"
        case .dailylife:
            return "Daily Life"
        case .commute:
            return "Commute"
        case .sleep:
            return "Sleep"
        case .activities:
            return "Activities"
        case .notifications:
            return "Notifications"
        }
    }
}
