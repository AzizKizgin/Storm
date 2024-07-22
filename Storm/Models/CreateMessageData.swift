//
//  CreateMessageData.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation

struct CreateMessageData: Encodable {
    var content: String
    var receiverId: String
    var chatId: String
    var groupId: String
    var media: [String]?
    var createAt: String
    var editedAt: String?
}
