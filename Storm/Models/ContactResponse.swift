//
//  ContactResponse.swift
//  Storm
//
//  Created by Aziz Kızgın on 17.07.2024.
//

import Foundation

struct ContactResponse: Decodable, Hashable {
    let id: Int
    let contactUser: UserResponse
    let addedAt: String
}
