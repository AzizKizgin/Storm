//
//  ChatDataManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import Foundation
import Combine

class ChatDataManager {
    static let shared = ChatDataManager()
    private init() {}
    
    func getAllChats() -> AnyPublisher<[Chat], Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getAllChats(),
            requestType: .get
        )
    }
    
    func getChat(id: String) -> AnyPublisher<Chat, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getChat(id: id),
            requestType: .get
        )
    }
    
    func readChat(id: String) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.readChat(id: id),
            requestType: .post
        )
    }
    
    func sendMessage(data: CreateMessageData) -> AnyPublisher<Message, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.sendMessage(),
            data: data,
            requestType: .post
        )
    }
    
    func deleteMessage(id: Int) -> AnyPublisher<Message, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.deleteMessage(id: id),
            requestType: .delete
        )
    }
    
    func editMessage(id: Int, data: EditMessageData) -> AnyPublisher<Message, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.deleteMessage(id: id),
            data: data,
            requestType: .put
        )
    }
}
