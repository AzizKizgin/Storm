//
//  Message.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.07.2024.
//

import Foundation
//public class MessageDto
//{
//    public MessageType Type { get; set; }
//}

struct Message: Decodable {
    var id: Int
    var sender: UserResponse
    var chatId: Int?
    var groupId: Int?
    var content: String
    var createdAt: String
    var editedAt: String?
    var media: [String]
    var readBy: [String]
    var reactions: [String]
    var type: MessageType
}

enum MessageType: Decodable {
    case add, delete, edit, read, reaction
}



