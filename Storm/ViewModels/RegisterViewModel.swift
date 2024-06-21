//
//  RegisterViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

@MainActor
@Observable class RegisterViewModel {
    private let auth = FirebaseManager.shared.auth
    var registerInfo = RegisterInfo()
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    
    private var cancellable: AnyCancellable?
    
    func register() {
        if !validateFields() {
            return
        }
        self.isLoading = true
        cancellable = UserDataManager.shared.register(info: registerInfo)
            .sink(receiveCompletion: { completionResult in
                self.isLoading = false 
                switch completionResult {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { (user: UserResponse) in
                UserDataSource.shared.appendItem(user.toUser())
                self.isLoading = false
            })
    }
    
    private func validateFields() -> Bool {
        if registerInfo.email.isEmpty
            || registerInfo.username.isEmpty
            || registerInfo.password.isEmpty
            || registerInfo.confirmPassword.isEmpty{
            setError("Please fill all fields")
            return false
        }
        if !Utils.isValidEmail(for: registerInfo.email) {
            setError("Your email is invalid")
            return false
        }
        if !Utils.isPasswordValid(for: registerInfo.password){
            setError("The password must contain at least 8 characters, 1 special character and 1 uppercase letter.")
            return false
        }
        if registerInfo.password != registerInfo.confirmPassword {
            setError("Passwords do not match")
            return false
        }
        if !isChecked {
            setError("Please agree with terms")
            return false
        }
        return true
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
