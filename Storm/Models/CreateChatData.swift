//
//  CreateChatData.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation

struct CreateChatData: Encodable {
    var contactUserId: String
    var initialMessage: CreateMessageData
}
