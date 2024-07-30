//
//  SettingsViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable
class SettingsViewModel {
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var successMessage: LocalizedStringKey = ""
    var isLoading: Bool = false
    var isSuccess: Bool = false
    var showLogoutAlert: Bool = false
    
    private var cancellable: AnyCancellable?
    
    private var socketManager = SocketManager.shared
    
    deinit {
        cancellable?.cancel()
     }
    
    func changeUsername(username: String, completion: @escaping (Bool) -> Void) {
        if username.isEmpty {
            setError("Username must have at least 1 character")
            return
        }
        self.isLoading = true
        cancellable = UserDataManager.shared.changeUsername(data: UpdateUsernameData(username: username))
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    DispatchQueue.main.async {
                        completion(true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { message in
                print(message.message)
            })
    }
    
    func changeAbout(about: String, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        cancellable = UserDataManager.shared.changeUserAbout(data: UpdateUserAboutData(about: about))
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    DispatchQueue.main.async {
                        completion(true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { message in
                print(message.message)
            })
    }
    
    func changeImage(profilePicture: String, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        cancellable = UserDataManager.shared.changeUserImage(data: UpdateUserImageData(profilePicture: profilePicture))
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    DispatchQueue.main.async {
                        completion(true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { message in
                print(message.message)
            })
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        cancellable = UserDataManager.shared.logout()
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    DispatchQueue.main.async {
                        completion(true)
                        self.socketManager.closeConnection()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { message in
                UserDefaults.standard.removeObject(forKey: "token")
            })
    }
    
    func onLogoutPressed() {
        self.showLogoutAlert.toggle()
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
    
    private func setSuccess(_ message: String) {
        self.isSuccess = true
        self.successMessage = LocalizedStringKey(message)
    }
}
