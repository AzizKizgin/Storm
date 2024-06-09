//
//  User.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import FirebaseFirestore

enum UserStatus: String, Codable {
    case offline, online
}

struct User: Codable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var profilePictureUrl: String
    var status: Int
    var lastSeen: Date
}
