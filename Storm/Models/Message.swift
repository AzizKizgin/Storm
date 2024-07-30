//
//  Message.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.07.2024.
//

import Foundation
struct Message: Codable, Hashable {
    var id: Int
    var sender: UserResponse
    var chatId: String?
    var groupId: Int?
    var content: String
    var createdAt: String
    var editedAt: String?
    var media: [String]
    var readBy: [String]
    var reactions: [EmojiReaction]
    var type: Int? = 0
}

enum MessageType: Int {
    case add = 0, delete, edit, reaction
}



