//
//  SocketManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 30.07.2024.
//

import Foundation
import SignalRClient

class SocketManager {
    
    static let shared = SocketManager()
    private init() {
        self.startConnection()
    }
    
    var connection: HubConnection?
    
    var onMessageReceived: ((Message) -> Void)?
    var onReadReceived: ((String) -> Void)?
    
    private func startConnection() {
        let url = Endpoints.getWebsocketURL()
        connection = HubConnectionBuilder(url: url)
            .build()

        self.recieveMessages()
        self.recieveReads()

        connection?.start()
    }
    
    private func recieveMessages() {
        connection?.on(method: "ReceiveMessage", callback: { (message: String) in
            if let decodedData = Data(base64Encoded: message),
               let jsonString = String(data: decodedData, encoding: .utf8),
               let jsonData = jsonString.data(using: .utf8) {
                do {
                    let message = try JSONDecoder().decode(Message.self, from: jsonData)
                    self.onMessageReceived?(message)
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            } else {
                print("Failed to decode Base64 string.")
            }
        })
    }
    
    private func recieveReads() {
        connection?.on(method: "RecieveRead", callback: { (userId: String) in
            self.onReadReceived?(userId)
        })
    }
    
    private func joinRoom(id: String) async {
        await withCheckedContinuation { continuation in
            connection?.invoke(method: "JoinRoom", id) { error in
                if let error = error {
                    print("Error joining room: \(error)")
                }
                continuation.resume()
            }
        }
    }
    
    private func leaveRoom(id: String) async {
        await withCheckedContinuation { continuation in
            connection?.invoke(method: "LeaveRoom", id) { error in
                if let error = error {
                    print("Error leaving room: \(error)")
                }
                continuation.resume()
            }
        }
    }
    
    func sendMessageToHub(message: Message, chatId: String?) {
        do {
            let encodedMessage = try JSONEncoder().encode(message)
            connection?.invoke(method: "SendMessage", chatId, encodedMessage) { error  in
                if let error = error {
                    print("Error sending message: \(error)")
                }
            }
        } catch(let error) {
            print(error)
        }
    }
    
    func sendReadInfoToHub(chatId: String?, userId: String?) {
        connection?.invoke(method: "ReadMessage", chatId, userId ){ error in
            if let error = error {
                print("Error reading message: \(error)")
            }
        }
    }
    
    func joinRooms(chatIds: [String]) async {
        await withTaskGroup(of: Void.self) { taskGroup in
            for id in chatIds {
                taskGroup.addTask {
                    await self.joinRoom(id: id)
                }
            }
        }
    }

    func leaveRooms(chatIds: [String]) async {
        await withTaskGroup(of: Void.self) { taskGroup in
            for id in chatIds {
                taskGroup.addTask {
                    await self.joinRoom(id: id)
                }
            }
        }
    }
}
