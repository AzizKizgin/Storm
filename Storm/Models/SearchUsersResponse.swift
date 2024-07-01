//
//  SearchUsersResponse.swift
//  Storm
//
//  Created by Aziz Kızgın on 1.07.2024.
//

import Foundation

struct SearchUsersResponse: Decodable {
    let users: [UserResponse]
    let page: Int
    let pageSize: Int
    let totalPages: Int
}
