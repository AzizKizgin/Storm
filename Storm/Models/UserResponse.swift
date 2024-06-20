//
//  UserResponse.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation

struct UserResponse: Decodable {
    var id: String
    var email: String
    var username: String
    var about: String
    var createdAt: String
    var profilePicture: String?
    var token: String?
}
