//
//  Emoji.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation

enum EmojiType: String, Codable {
    case heart, fire, joy, folded, thumbsUp, openMouth
}

struct Emoji: Codable, Hashable {
    let userId: String
    let type: EmojiType
}
