//
//  EmojiReaction.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation

struct EmojiReaction: Decodable, Hashable {
    var id: Int
    var emoji: String
    var messageId: Int
    var user: UserResponse
}
