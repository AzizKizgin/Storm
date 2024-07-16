//
//  UserResponse.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation

struct UserResponse: Decodable, Hashable {
    var id: String
    var email: String
    var username: String
    var about: String
    var createdAt: String
    var profilePicture: String?
    var token: String?
    var contactList: [String] = []
    
    // user response to local User
    func toUser() -> User {
        return User(id: self.id, email: self.email, username: self.username, about: self.about, createdAt: self.createdAt, profilePicture: self.profilePicture ?? "")
    }
    
    func isContactOf(userId: String?) -> Bool {
        if let userId, contactList.contains(userId) {
            return true
        }
        return false
    }
}
