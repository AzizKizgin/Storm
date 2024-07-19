//
//  TabScreenType.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import Foundation

enum TabScreenType {
    case chatList, contacts, settings
    
    var title: String {
        switch self {
        case .chatList:
            return "Chats"
        case .contacts:
            return "Contacts"
        case .settings:
            return "Settings"
        }
         
    }
}
