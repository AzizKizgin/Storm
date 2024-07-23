//
//  Chat.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation
struct Chat: Decodable, Hashable {
    var id: String
    var members: [ChatMember]
    var messages: [Message]
}
