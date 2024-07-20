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


@Observable class RegisterViewModel {
    var registerInfo = RegisterInfo()
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    func register(completion: @escaping (UserResponse?) -> Void) {
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
                    completion(nil)
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { user in
                completion(user)
                UserDefaults.standard.set(user.token, forKey: "token")
                self.isSuccess = true
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
