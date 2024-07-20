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
    var users: [UserResponse] = []
    var searchObject: SearchUsersQuery = SearchUsersQuery()
    var selectedUser: UserResponse?
    var isChecked: Bool = false
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var isListLoading: Bool = false
    var isSuccess: Bool = false
    var showRemoveAlert: Bool = false
    var removingContact: UserResponse?
    var totalPages: Int = 0
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    func reset() {
        self.totalPages = 0
        self.users.removeAll()
    }
    
    func refresh() {
        self.searchObject.page = 0
        self.totalPages = 0
        self.users.removeAll()
        self.searchUsers()
    }
    
    func loadMoreContent(item: UserResponse){
        let thresholdIndex = users.last?.id
        if thresholdIndex == item.id, (searchObject.page + 1) <= totalPages {
            searchObject.page += 1
            searchUsers()
        }
    }
    
    func searchUsers() {
        if self.searchObject.username.isEmpty {
            self.searchObject = SearchUsersQuery()
            self.totalPages = 0
            self.users.removeAll()
        }
        self.isListLoading = true
        cancellable = ContactDataManager.shared.searchUsers(query: self.searchObject)
            .sink(receiveCompletion: { completionResult in
                self.isListLoading = false
                switch completionResult {
                case .finished:
                    print("")
                case .failure(let error):
                    print(error.localizedDescription)
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { result in
                self.totalPages = result.totalPages
                self.users.append(contentsOf: result.users)
                self.isSuccess = true
                self.isListLoading = false
            })
    }
    
    func addContact(id: String) {
        self.isLoading = true
        cancellable = ContactDataManager.shared.addContact(createContactInfo: CreateContactDto(contactUserId: id))
            .sink(receiveCompletion: { completionResult in
                self.isLoading = false
                switch completionResult {
                case .finished:
                    if let index = self.users.firstIndex(where: { $0.id == id }) {
                        self.users[index].isContactOfCurrentUser = true
                    }
                case .failure(let error):
                    self.setError(error.localizedDescription)
                }
            }, receiveValue: { result in
                self.isLoading = false
            })
    }
    
    func removeContact() {
        if let id = removingContact?.id {
            self.isLoading = true
            cancellable = ContactDataManager.shared.removeContact(contactId: id)
                .sink(receiveCompletion: { completionResult in
                    self.isLoading = false
                    switch completionResult {
                    case .finished:
                        if let index = self.users.firstIndex(where: { $0.id == id }) {
                            self.users[index].isContactOfCurrentUser = false
                        }
                    case .failure(let error):
                        self.setError(error.localizedDescription)
                    }
                }, receiveValue: { result in
                    self.isLoading = false
                })
        }
    }
    
    func showRemoveContactAlert(contact: UserResponse) {
        self.removingContact = contact
        self.showRemoveAlert.toggle()
    }
    
    func cancelRemove() {
        self.removingContact = nil
        self.showRemoveAlert.toggle()
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
    
}
