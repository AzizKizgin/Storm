//
//  Message.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import FirebaseFirestore

struct Message: Codable {
    @DocumentID var id: String?
    var senderId: String
    var image: String?
    var text: String
    var timestamp: Date
    var readBy: [Contact]
    var emoji: [Emoji]
}
