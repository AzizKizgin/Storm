//
//  LoginViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable
class LoginViewModel {
    var loginInfo = LoginInfo()
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    
    func login(completion: @escaping (UserResponse?) -> Void) {
        if !validateFields() {
            return
        }
        self.isLoading = true
        cancellable = UserDataManager.shared.login(info: loginInfo)
            .sink(receiveCompletion: { completionResult in
                self.isLoading = false
                switch completionResult {
                case .finished:
                    print("finished")
                case .failure(let error):
                    completion(nil)
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { (user: UserResponse) in
                completion(user)
                UserDefaults.standard.set(user.token, forKey: "token")
                self.isSuccess = true
                self.isLoading = false
            })
    }
    
    private func validateFields() -> Bool {
        if loginInfo.email.isEmpty || loginInfo.password.isEmpty {
            setError("Please fill all fields")
            return false
        }
        return true
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
