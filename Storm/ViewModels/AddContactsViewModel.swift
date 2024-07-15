//
//  AddContactsViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable class AddContactsViewModel {
    var searchResult: SearchUsersResponse?
    var searchObject: SearchUsersQuery = SearchUsersQuery()
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    func searchUsers() {
        self.isLoading = true
        cancellable = ContactDataManager.shared.searchUsers(query: self.searchObject)
            .sink(receiveCompletion: { completionResult in
                self.isLoading = false
                switch completionResult {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { result in
                Task {
                    self.searchResult = result
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
