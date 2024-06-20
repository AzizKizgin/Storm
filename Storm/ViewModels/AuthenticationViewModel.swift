//
//  AuthenticationViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation

@Observable class AuthenticationViewModel {
    private let auth = FirebaseManager.shared.auth
    var userInfo = RegisterInfo()
    var isChecked: Bool = false
    
    func register() {
        
    }
}
