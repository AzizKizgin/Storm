//
//  Chat.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation
struct Chat: Decodable {
    var id: Int
    var members: [ChatMember]
    var messages: [Message]
}
