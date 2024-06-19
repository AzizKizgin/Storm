//
//  AuthenticationViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation

@Observable class AuthenticationViewModel {
    private let auth = FirebaseManager.shared.auth
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var isChecked: Bool = false
    
    func register() {
        
    }
}
