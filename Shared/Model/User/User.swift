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
    @Published var name: String

    init(from entity: UserEntity) {
        let avatar = Avatar(rawValue: entity.avatar ?? "none") ?? .none
        self.avatar = avatar
        self.name = entity.name ?? ""
    }
    
    func save(context: NSManagedObjectContext) {
        let user = UserEntity.current(for: context)
        user.avatar = avatar.rawValue
        user.name = name
        
        do {
            try context.save()
        } catch {
            print("Error saving user: \(error.localizedDescription)")
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
            print("Unable to load current user: \(error.localizedDescription)")
        }
        
        if user == nil {
            user = UserEntity(context: context)
            do {
                try context.save()
            } catch {
                print("Unable to save new user: \(error.localizedDescription)")
            }
        }
        
        return user!
    }
}
