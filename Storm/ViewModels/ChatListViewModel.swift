//
//  ChatListViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable class ChatListViewModel {
    var appUserId: String = ""
    var searchText: String = ""
    var chats: [Chat] = []
    var filteredChats: [Chat] = []
    var selectedChats: [String] = []
    var chatForNavigation: String?
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var showSelectContact: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
     }
    
    func getAllChats() {
        self.isLoading = true
        cancellable = ChatDataManager.shared.getAllChats()
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
                self.chats = result
            })
    }
    
    func search() {
        if searchText.isEmpty && appUserId.isEmpty {
            filteredChats = chats
        }
        else {
            filteredChats = searchChats()
        }
    }
    
    private func searchChats() -> [Chat] {
        return chats.filter { chat in
            chat.members.contains { (member:ChatMember) in
                member.user.id != appUserId && member.user.username.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
}
