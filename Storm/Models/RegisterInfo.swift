//
//  RegisterInfo.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation

struct RegisterInfo: Encodable {
    var email: String
    var username: String
    var password: String
    var confirmPassword: String
    
    init() {
        self.email = ""
        self.username = ""
        self.password = ""
        self.confirmPassword = ""
    }
}
