//
//  Chats.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import FirebaseFirestore

enum ChatType: String, Codable {
    case `private`, group
}

struct Chat: Codable {
    @DocumentID var id: String?
    var type: Int
    var participants: [Contact]
    var lastMessage: Message
} 
