//
//  DummyMessage.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation

let dummyMessage1 = Message(id: 1, sender: dummyUserResponse,chatId: "1", content: "Hello", createdAt: "24.07.2024", media: [], readBy: ["userId","userId2"], reactions: [])

let dummyMessage2 = Message(id: 2, sender: dummyUserResponse2,chatId: "1", content: "Hi!!!", createdAt: "24.07.2024", media: [], readBy: ["userId2"], reactions: [])

let dummyMessage3 = Message(id: 3, sender: dummyUserResponse3,chatId: "2", content: "It is a message", createdAt: "24.07.2024", media: [], readBy: ["userId3"], reactions: [])

let dummyMessage4 = Message(id: 4, sender: dummyUserResponse,chatId: "2", content: "Ok!", createdAt: "24.07.2024", media: [], readBy: ["userId","userId3"], reactions: [])
