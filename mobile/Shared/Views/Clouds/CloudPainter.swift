//
//  CloudPainter.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/22/20.
//

import SwiftUI

struct CloudPainter: View {
    let offset: CGFloat
    var cloudConfig: CloudConfig
    
    /// Init for previews only.
    fileprivate init(offset: CGFloat = 0.0) {
        self.offset = offset
        cloudConfig = CloudConfig()
    }
    
    init(offset: CGFloat, cloudConfig: CloudConfig) {
        self.offset = offset
        self.cloudConfig = cloudConfig
    }
    
    var body: some View {
        ZStack {
         ForEach(cloudConfig.centers) { center in
                 Cloud().position(x: center.x, y: center.y)
             }
         }
        .frame(height: cloudConfig.height, alignment: .leading)
        .offset(x: -offset, y: 0.0)
        .padding(.vertical, Cloud.height / 2)
        .animation(defaultAnimation)
    }
}

struct CloudPainter_Previews: PreviewProvider {
    static var previews: some View {
        CloudPainter()
    }
}

struct CloudConfig {
    private(set) var centers: [CloudPoint]
    let width: CGFloat
    let height: CGFloat
    
    struct CloudPoint: Identifiable {
        let id = UUID()
        let x: CGFloat
        let y: CGFloat
    }
    
    init(width: Double = defaultWidth, height: Double = defaultHeight) {
        self.width = CGFloat(width)
        self.height = CGFloat(height)
        centers = []
        var offset = 0.0
        
        var lastY = 0.0
        var allDy: [Double] = []
        
        /// Generates the next y value.
        func nextY() -> Double {
            Double.random(in: 0...height)
        }
        
        /// Computes the average dy between all clouds, if `with` is to be included.
        func averageDy(with dy: Double) -> Double {
            (allDy.reduce(0) { $0 + $1 } + dy) / Double(allDy.count + 1)
        }
        
        /// Returns whether or not the cloud is too close to other clouds.
        func cloudIsTooClose(with xy: (x: Double, y: Double)) -> Bool {
            let x = CGFloat(xy.x)
            let y = CGFloat(xy.y)
            for cloud in centers {
                let dx = abs(cloud.x - x)
                if dx < Cloud.width {
                    let dy = abs(cloud.y - y)
                    guard Double(dy) > minVerticalSpacing else { return true }
                }
            }
            return false
        }
        
        while offset < width {
            let x = offset
            var y = nextY()
            var dy = abs(y - lastY)
            
            // Prevent too little in vertical variance between this and nearby clouds.
            // Prevent too little in average vertical variable between all clouds.
            while cloudIsTooClose(with: (x: x, y: y)), averageDy(with: dy) < minAverageDy {
                y = nextY()
                dy = abs(y - lastY)
            }
            
            centers.append(CloudPoint(x: CGFloat(x), y: CGFloat(y)))
            offset += Double.random(in: minHorizontalSpacing...maxHorizontalSpacing)
            
            // Set final values.
            lastY = y
            allDy.append(dy)
        }
    }
    
    // MARK: - Drawing Constants
    
    static let defaultWidth = 1000.0
    static let defaultHeight = 80.0
    private let minHorizontalSpacing = 70.0
    private let maxHorizontalSpacing = 250.0
    private let minVerticalSpacing = 10.0
    private let minAverageDy = 50.0
}
