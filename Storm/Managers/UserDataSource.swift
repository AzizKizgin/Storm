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

    func removeItem(_ user: User) {
        modelContext.delete(user)
    }
}
