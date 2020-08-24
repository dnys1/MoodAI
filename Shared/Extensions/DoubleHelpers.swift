//
//  DoubleHelpers.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import Foundation

extension Double {
    func clamp(in range: Range<Double>) -> Double {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
