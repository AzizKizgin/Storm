//
//  DummyChatMember.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation

let dummyMember1 = ChatMember(user: dummyUserResponse, chatId: "1", joinedAt: "23.07.2024", isMuted: true, isPinned: true, isArchived: false)

let dummyMember2 = ChatMember(user: dummyUserResponse2, chatId: "1", joinedAt: "23.07.2024", isMuted: false, isPinned: false, isArchived: false)

let dummyMember3 = ChatMember(user: dummyUserResponse, chatId: "2", joinedAt: "23.07.2024", isMuted: true, isPinned: true, isArchived: false)

let dummyMember4 = ChatMember(user: dummyUserResponse3, chatId: "2", joinedAt: "23.07.2024", isMuted: false, isPinned: false, isArchived: false)

let dummyChatMembers = [dummyMember1,dummyMember2]
let dummyChatMembers2 = [dummyMember3,dummyMember4]
