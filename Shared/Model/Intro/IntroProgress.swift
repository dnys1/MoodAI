//
//  IntroProgress.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import Foundation
import CoreData

struct IntroProgress {
    var stage: IntroStage
    var complete: Bool
    
    init(stage: IntroStage, complete: Bool = false) {
        self.stage = stage
        self.complete = complete
    }
    
    init(from entity: IntroProgressEntity) {
        self.complete = entity.complete
        switch entity.stage {
        case 0:
            self.stage = .start
        case 1:
            let step = IntroStep(rawValue: Int(entity.step))
            if let screen = step {
                self.stage = .step(screen)
            } else {
                NSLog("Invalid step: \(entity.step)")
                self.stage = .start
            }
        case 2:
            self.stage = .finish
        default:
            NSLog("Invalid stage: \(entity.stage)")
            self.stage = .start
        }
    }
    
    mutating func setStep(_ step: IntroStage) {
        self.stage = step
    }
    
    mutating func setComplete() {
        self.complete = true
    }
    
    func save(context: NSManagedObjectContext) {
        let entity = IntroProgressEntity.load(context: context)
        
        switch stage {
        case .loading:
            return
        case .start:
            entity.stage = 0
        case .step(let step):
            let index = IntroStep.allCases.firstIndex(of: step)!
            entity.stage = 1
            entity.step = Int16(index)
        case .finish:
            entity.stage = 2
        }
        
        entity.complete = complete
        
        do {
            try context.save()
        } catch {
            NSLog("Error saving progress: \(error.localizedDescription)")
        }
    }
    
    static func load(context: NSManagedObjectContext) -> IntroProgress {
        let entity = IntroProgressEntity.load(context: context)
        return self.init(from: entity)
    }
    
    static func loading() -> IntroProgress {
        return self.init(stage: .loading)
    }
}

extension IntroProgressEntity {
    static func load(context: NSManagedObjectContext) -> IntroProgressEntity {
        let request = NSFetchRequest<IntroProgressEntity>(entityName: "IntroProgressEntity")
        var progress: IntroProgressEntity?
        do {
            progress = try context.fetch(request).first
        } catch {
            NSLog("Error loading progress: \(error.localizedDescription)")
        }
        
        if progress == nil {
            progress = IntroProgressEntity(context: context)
            do {
                try context.save()
            } catch {
                NSLog("Error saving progress: \(error.localizedDescription)")
            }
        }
        
        return progress!
    }
}
