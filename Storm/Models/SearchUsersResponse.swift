//
//  SearchUsersResponse.swift
//  Storm
//
//  Created by Aziz Kızgın on 1.07.2024.
//

import Foundation

struct SearchUsersResponse: Decodable {
    var users: [UserResponse]
    let page: Int
    let pageSize: Int
    let totalPages: Int
}

let dummySearchUsersResponse = SearchUsersResponse(users: [dummyUserResponse, dummyUserResponse2, dummyUserResponse3], page: 1, pageSize: 1, totalPages: 1)
