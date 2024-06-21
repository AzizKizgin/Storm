//
//  UserDataManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation
import Combine

class UserDataManager {
    static let shared = UserDataManager()
    private init() {}
    
    func register(info: RegisterInfo) -> AnyPublisher<UserResponse, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getRegisterURL(),
            data: info,
            requestType: .post
        )
    }
    
    func login(info: LoginInfo) -> AnyPublisher<UserResponse, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getLoginURL(),
            data: info,
            requestType: .post
        )
    }
}
