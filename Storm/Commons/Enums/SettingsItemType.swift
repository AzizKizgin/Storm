//
//  SettingsItemType.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import Foundation
import SwiftUI

enum SettingsItemType: String {
    case username
    case about

    var title: LocalizedStringKey {
        switch self {
        case .username:
            return "Username"
        case .about:
            return "About"
        }
    }

    var icon: String {
        switch self {
        case .username:
            return "person"
        case .about:
            return "info.circle"
        }
    }
    
    var maxSize: Int {
        switch self {
        case .username:
            return 25
        case .about:
            return 100
        }
    }
}
