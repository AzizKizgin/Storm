//
//  ContactsViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 1.07.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable class ContactsViewModel {
    var searchText: String = ""
    var contacts: [ContactResponse] = []
    var filteredContacts: [ContactResponse] = []
    var selectedContact: ContactResponse?
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var isListLoading: Bool = false
    var showRemoveAlert: Bool = false
    var removingContact: ContactResponse?
    var showAddContactScreen: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    func getContacts() {
        self.isListLoading = true
        cancellable = ContactDataManager.shared.getAllContacts()
            .sink(receiveCompletion: { completionResult in
                self.isListLoading = false
                switch completionResult {
                case .finished:
                    self.isListLoading = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { result in
                self.contacts = result
            })
    }
    
    func removeContact() {
        if let id = removingContact?.contactUser.id {
            self.isLoading = true
            cancellable = ContactDataManager.shared.removeContact(contactId: id)
                .sink(receiveCompletion: { completionResult in
                    self.isLoading = false
                    switch completionResult {
                    case .finished:
                        if let index = self.contacts.firstIndex(where: { $0.contactUser.id == id }) {
                            self.contacts.remove(at: index)
                        }
                    case .failure(let error):
                        self.setError(error.localizedDescription)
                    }
                }, receiveValue: { result in
                    self.isLoading = false
                })
        }
    }
    
    func showRemoveContactAlert(contact: ContactResponse) {
        self.removingContact = contact
        self.showRemoveAlert.toggle()
    }
    
    func cancelRemove() {
        self.removingContact = nil
        self.showRemoveAlert.toggle()
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
