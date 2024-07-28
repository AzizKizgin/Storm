//
//  SelectContactViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable class SelectContactViewModel {
    var searchText: String = ""
    var contacts: [ContactResponse] = []
    var selectedContact: UserResponse?
    var filteredContacts: [ContactResponse] = []
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    func getContacts() {
        self.isLoading = true
        cancellable = ContactDataManager.shared.getAllContacts()
            .sink(receiveCompletion: { completionResult in
                self.isLoading = false
                switch completionResult {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { result in
                self.contacts = result
            })
    }
    
    func search() {
        if searchText.isEmpty {
            filteredContacts = contacts
        }
        else {
        filteredContacts = contacts.filter{$0.contactUser.username.starts(with: searchText)}
        }
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
    
}
