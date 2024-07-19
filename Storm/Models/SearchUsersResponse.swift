//
//  SearchUsersResponse.swift
//  Storm
//
//  Created by Aziz Kızgın on 1.07.2024.
//

import Foundation

struct SearchUsersResponse: Decodable {
    var users: [UserResponse] = []
    var page: Int = 1
    var pageSize: Int = 20
    var totalPages: Int = 1
}

let dummySearchUsersResponse = SearchUsersResponse(users: [dummyUserResponse, dummyUserResponse2, dummyUserResponse3], page: 1, pageSize: 1, totalPages: 1)
