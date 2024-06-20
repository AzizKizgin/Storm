//
//  User.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation
import SwiftData

@Model
class User {
    var id: String
    var email: String
    var username: String
    var about: String
    var createdAt: String
    var profilePicture: String
    
    init(id: String, email: String, username: String, about: String, createdAt: String, profilePicture: String = "") {
        self.id = id
        self.email = email
        self.username = username
        self.about = about
        self.createdAt = createdAt
        self.profilePicture = profilePicture
    }
}
