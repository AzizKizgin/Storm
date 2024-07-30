//
//  ChatViewModel.swift
//  Storm
//
//  Created by Aziz Kızgın on 25.07.2024.
//

import Foundation
import SwiftUI
import Combine
import SignalRClient

@Observable class ChatViewModel {
    var chatId: String?
    var appUserId: String?
    var content: String = ""
    var searchText: String = ""
    var contact: UserResponse?
    var messages: [Message] = []
    var filteredMessages: [Message] = []
    var selectedChats: [String] = []
    var errorMessage: LocalizedStringKey = ""
    var showError: Bool = false
    var isLoading: Bool = false
    var showSelectContact: Bool = false
    
    @ObservationIgnored
    private var cancellable: AnyCancellable?
    @ObservationIgnored
    private var socketManager = SocketManager.shared
    
    deinit {
        cancellable?.cancel()
    }
    
    init (){
        socketManager.onMessageReceived = { message in
            self.handleMessage(result: message)
        }
        
        socketManager.onReadReceived = { userId in
            self.updateReadBy(for: &self.messages, with: userId)
        }
    }
    
    func onAppear(contact: UserResponse?, chatId: String?, appUserId: String?)  {
        self.contact = contact
        self.chatId = chatId
        self.appUserId = appUserId
        Task {
            await self.getChat()
        }
    }

    func sendMessageToHub(message: Message) {
        socketManager.sendMessageToHub(message: message, chatId: chatId)
    }
    
    func sendReadInfoToHub() {
        socketManager.sendReadInfoToHub(chatId: chatId, userId: appUserId)
    }
    
    func getChat() async {
        guard chatId != nil || contact?.id != nil else {
            return
        }
        self.isLoading = true
        cancellable = ChatDataManager.shared.getChat(id: (chatId ?? contact?.id)!)
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
                self.contact = result.members.first{$0.user.id != self.appUserId}?.user
                self.messages = result.messages
                self.chatId = result.id
            })
    }
    
    func readChat() {
        guard let chatId else{
            setError("Chat not found")
            return
        }
        self.isLoading = true
        cancellable = ChatDataManager.shared.readChat(id: chatId)
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
                self.sendReadInfoToHub()
            })
    }
    
    func sendMessage() {
        guard !content.isEmpty else {
            return
        }
        self.isLoading = true
        let data = CreateMessageData(
            content: content,
            receiverId: contact?.id,
            chatId: chatId
        )
        cancellable = ChatDataManager.shared.sendMessage(data: data)
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
                self.handleMessage(result: result)
                self.sendMessageToHub(message: result)
            })
    }
    
    func deleteMessage(id: Int) {
        guard !content.isEmpty else {
            return
        }
        
        self.isLoading = true
        cancellable = ChatDataManager.shared.deleteMessage(id: id)
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
                if let index = self.messages.firstIndex(of: result) {
                    self.messages.remove(at: index)
                    self.sendMessageToHub(message: result)
                }
            })
    }
    
    func editMessage(id: Int) {
        guard !content.isEmpty else {
            return
        }
        
        self.isLoading = true
        
        cancellable = ChatDataManager.shared.editMessage(id: id, data: EditMessageData(content: content))
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
                if let index = self.messages.firstIndex(of: result) {
                    self.messages[index] = result
                    self.sendMessageToHub(message: result)
                }
            })
    }
    
    func search() {
        if searchText.isEmpty {
            filteredMessages = messages
        }
        else {
            filteredMessages = searchMessages()
        }
    }
    
    private func searchMessages() -> [Message] {
        return messages.filter { message in
            message.content.contains(searchText)
        }
    }
    
    private func setError(_ error: String) {
        self.errorMessage = LocalizedStringKey(error)
        self.showError = true
    }
    
    private func handleMessage(result: Message) {
        if let index = self.messages.firstIndex(where: {$0.id == result.id}) {
            switch result.type {
            case MessageType.delete.rawValue:
                self.messages.remove(at: index)
            case MessageType.edit.rawValue:
                self.messages[index] = result
            case MessageType.reaction.rawValue:
                self.messages[index] = result
            default:
                self.messages[index] = result
            }
        }
        else {
            self.messages.append(result)
        }
    }
    
    func updateReadBy(for messages: inout [Message], with userId: String) {
        for i in 0..<messages.count {
            if !messages[i].readBy.contains(userId) {
                messages[i].readBy.append(userId)
            }
        }
    }
}

