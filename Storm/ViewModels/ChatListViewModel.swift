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
    
    @ObservationIgnored
    private var socketManager = SocketManager.shared
    
    init (){
      
        socketManager.onMessageReceived = { message in
            self.handleMessage(result: message)
        }
    }

    
    func closeConnection() {
        Task {
            cancellable?.cancel()
            let chatIds = self.chats.map { $0.id }
            await self.socketManager.leaveRooms(chatIds: chatIds)
        }
    }
    
    func getAllChats() async{
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
                Task {
                    let chatIds = result.map { $0.id }
                    await self.socketManager.joinRooms(chatIds: chatIds)
                }
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
    
    private func handleMessage(result: Message) {
        if let index = self.chats.firstIndex(where: {$0.id == result.chatId}) {
            if let messageIndex = chats[index].messages.firstIndex(of: result) {
                if result.type == MessageType.delete.rawValue {
                    chats[index].messages.remove(at: messageIndex)
                }
                else {
                    chats[index].messages[messageIndex] = result
                }
            }
            else if result.type == MessageType.add.rawValue {
                chats[index].messages.append(result)
            }
        }
        else if let chatId = result.chatId {
            let newChat = Chat(id: chatId, members: [ChatMember(user: result.sender, chatId: chatId, joinedAt: "")], messages: [result])
            self.chats.append(newChat)
        }
    }
}
