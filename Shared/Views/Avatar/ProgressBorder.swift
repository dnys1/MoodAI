//
//  CountdownView.swift
//  Memorize
//
//  Created by Dillon Nys on 7/30/20.
//

import SwiftUI

struct ProgressBorder: View {
    /// A value between 0 and 1 indicating how much of progress is complete.
    ///
    /// 0 indicates the no progress, while 1 indicates full progress.
    var percentComplete: Double
    
    private var endAngle: Angle {
        let degrees = 360 * percentComplete
        return Angle(degrees: degrees)
    }
    
    private var inactiveStartAngle: Angle {
        return Angle(degrees: min(360, endAngle.degrees))
    }
    
    private var inactiveEndAngle: Angle {
        Angle(degrees: 360)
    }
    
    init(complete: Double) {
        assert(complete >= 0 && complete <= 1)
        self.percentComplete = complete
    }
    
    init(remaining: Double) {
        assert(remaining >= 0 && remaining <= 1)
        self.percentComplete = 1 - remaining
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        let lineWidth = scaledLineWidth(for: size)
        return ZStack {
            Pie(startAngle: Angle(degrees: 0), endAngle: endAngle)
                .stroke(defaultTheme.highlightColor, lineWidth: lineWidth)
            Pie(startAngle: inactiveStartAngle, endAngle: inactiveEndAngle)
                .stroke(defaultTheme.grey, lineWidth: lineWidth)
        }
    }
    
    private func scaledLineWidth(for size: CGSize) -> CGFloat {
        let diameter = min(size.width, size.height)
        let lineWidth = (diameter / baseDiameter) * baseLineWidth
        return lineWidth
    }
    
    private let baseLineWidth: CGFloat = 5.0
    private let baseDiameter: CGFloat = 175.0
}
