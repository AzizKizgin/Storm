//
//  UserDataSource.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation
import SwiftData

@MainActor
final class UserDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext


    static let shared = UserDataSource()

   
    private init() {
        self.modelContainer = try! ModelContainer(for: User.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendItem(_ user: User) {
        modelContext.insert(user)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [User] {
        do {
            return try modelContext.fetch(FetchDescriptor<User>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem() {
        try! modelContext.delete(model: User.self)
    }
    
    func updateProperty<T>(prop: WritableKeyPath<User, T>, newValue: T) {
        do {
            if var user = try modelContext.fetch(FetchDescriptor<User>()).first {
                user[keyPath: prop] = newValue
                try modelContext.save()
            } else {
                print("User not found")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
