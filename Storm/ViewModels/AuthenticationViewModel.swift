//
//  AuthenticationViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import Combine
import SwiftUI

@Observable class AuthenticationViewModel {
    private let auth = FirebaseManager.shared.auth
    var registerInfo = RegisterInfo()
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var successMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var showSuccess: Bool = false
    
    private var cancellable: AnyCancellable?
    
    func register() {
        if !isChecked {
            setError("Please agree with terms")
            return
        }
        cancellable = UserManager.shared.register(info: registerInfo)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.showSuccess.toggle()
                case .failure(let error):
                    self.setError("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { (message: SuccessMessage) in
                self.successMessage = LocalizedStringKey(message.message)
            })
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
