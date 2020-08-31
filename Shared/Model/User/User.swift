//
//  User.swift
//  MoodAI
//
//  Created by Dillon Nys on 8/30/20.
//

import Foundation
import CoreData

class User: ObservableObject {
    @Published var avatar: Avatar

    init(from entity: UserEntity) {
        let avatar = Avatar(rawValue: entity.avatar ?? "none") ?? .none
        self.avatar = avatar
    }
    
    func save(context: NSManagedObjectContext) {
        let entity = UserEntity.current(for: context)
        entity.avatar = avatar.rawValue
        
        do {
            try context.save()
        } catch {
            fatalError("Error saving user: \(error.localizedDescription)")
        }
    }
    
    static func current(for context: NSManagedObjectContext) -> User {
        let entity = UserEntity.current(for: context)
        return User(from: entity)
    }
}

extension UserEntity {
    static func current(for context: NSManagedObjectContext) -> UserEntity {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        var user: UserEntity?
        do {
            user = try context.fetch(request).first
        } catch {
            fatalError("Unable to load current user: \(error.localizedDescription)")
        }
        
        if user == nil {
            user = UserEntity(context: context)
            do {
                try context.save()
            } catch {
                fatalError("Unable to save new user: \(error.localizedDescription)")
            }
        }
        
        return user!
    }
}
