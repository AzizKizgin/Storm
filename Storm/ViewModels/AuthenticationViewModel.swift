//
//  AuthenticationViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

@MainActor
@Observable class AuthenticationViewModel {
    private let auth = FirebaseManager.shared.auth
    var registerInfo = RegisterInfo()
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    
    private var cancellable: AnyCancellable?
    
    func register() {
        if !isChecked {
            setError("Please agree with terms")
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
                    self.setError("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { (user: UserResponse) in
                UserDataSource.shared.appendItem(user.toUser())
                self.isLoading = false
            })
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
