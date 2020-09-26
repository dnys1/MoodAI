//
//  IntroProgress.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import Foundation
import CoreData

class IntroProgress: ObservableObject {
    private var entity: IntroProgressEntity
    @Published var stage: IntroStage
    @Published var complete: Bool
    
    init(stage: IntroStage, complete: Bool = false, for context: NSManagedObjectContext) {
        let entity = IntroProgressEntity(context: context)
        
        switch stage {
        case .loading:
            break
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
        
        self.stage = stage
        self.complete = complete
        self.entity = entity
        
        do {
            try context.save()
        } catch {
            print("Error creating IntroProgressEntity: \(error.localizedDescription)")
        }
    }
    
    init(from entity: IntroProgressEntity) {
        self.entity = entity
        self.complete = entity.complete
        switch entity.stage {
        case 0:
            self.stage = .start
        case 1:
            let step = IntroStep(rawValue: Int(entity.step))
            if let step = step {
                self.stage = .step(step)
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
    
    func save() {
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
            try entity.managedObjectContext?.save()
        } catch {
            NSLog("Error saving progress: \(error.localizedDescription)")
        }
    }
    
    static func current(for context: NSManagedObjectContext) -> IntroProgress {
        let entity = IntroProgressEntity.current(for: context)
        return IntroProgress(from: entity)
    }
}

extension IntroProgressEntity {
    static func from(progress: IntroProgress, for context: NSManagedObjectContext) -> IntroProgressEntity {
        let entity = IntroProgressEntity(context: context)
        
        switch progress.stage {
        case .loading:
            break
        case .start:
            entity.stage = 0
        case .step(let step):
            let index = IntroStep.allCases.firstIndex(of: step)!
            entity.stage = 1
            entity.step = Int16(index)
        case .finish:
            entity.stage = 2
        }
        
        entity.complete = progress.complete
        
        return entity
    }
    
    static func current(for context: NSManagedObjectContext) -> IntroProgressEntity {
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
