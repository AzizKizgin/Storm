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
    var usernameInfo = UpdateUsernameData()
    var aboutInfo = UpdateUserAboutData()
    var imageInfo = UpdateUserImageData()
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    func changeUsername() {
        if usernameInfo.username.isEmpty {
            setError("Username must have at least 1 character")
            return
        }
        self.isLoading = true
        cancellable = UserDataManager.shared.changeUsername(data: usernameInfo)
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { _ in
                Task {
                    await UserDataSource.shared.updateProperty(prop: \.username, newValue: self.usernameInfo.username)
                    self.isSuccess = true
                    self.isLoading = false
                }
            })
    }
    
    func changeAbout() {
        self.isLoading = true
        cancellable = UserDataManager.shared.changeUserAbout(data: aboutInfo)
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { _ in
                Task {
                    await UserDataSource.shared.updateProperty(prop: \.about, newValue: self.aboutInfo.about)
                    self.isSuccess = true
                    self.isLoading = false
                }
            })
    }
    
    func changeImage() {
        self.isLoading = true
        cancellable = UserDataManager.shared.changeUserImage(data: imageInfo)
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { _ in
                Task {
                    await UserDataSource.shared.updateProperty(prop: \.profilePicture, newValue: self.imageInfo.profilePicture)
                    self.isSuccess = true
                    self.isLoading = false
                }
            })
    }
    
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
