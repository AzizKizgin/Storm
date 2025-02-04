//
//  ChatMember.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.07.2024.
//

import Foundation
   
struct ChatMember: Decodable, Hashable {
    var user: UserResponse
    var chatId: String
    var joinedAt: String
    var isDeleted: Bool = false
    var isMuted: Bool = false
    var isPinned: Bool = false
    var isArchived: Bool = false
}
