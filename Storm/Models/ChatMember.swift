//
//  ChatMember.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.07.2024.
//

import Foundation
   
struct ChatMember: Decodable {
    var user: UserResponse
    var chatId: Int
    var joinedAt: String
    var isDeleted: Bool
    var isMuted: Bool
    var isPinned: Bool
    var isArchived: Bool
}
 
