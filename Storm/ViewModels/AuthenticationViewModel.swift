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

@Observable class AuthenticationViewModel {
//    @ObservationIgnored
//    @Environment(\.modelContext) private var modelContext
    private let auth = FirebaseManager.shared.auth
    var registerInfo = RegisterInfo()
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var successMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var showSuccess: Bool = false
    
    private var cancellable: AnyCancellable?
    
    func register(completion: @escaping (UserResponse?) -> Void) {
        if !isChecked {
            setError("Please agree with terms")
            completion(nil)
            return
        }
        cancellable = UserDataManager.shared.register(info: registerInfo)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.setError("Error: \(error.localizedDescription)")
                    completion(nil)
                }
            }, receiveValue: { (user: UserResponse) in
                completion(user)
            })
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
