//
//  IntroStep.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import Foundation

enum IntroStage: Equatable {
    case loading
    case start
    case step(_ step: IntroStep)
    case finish
}
