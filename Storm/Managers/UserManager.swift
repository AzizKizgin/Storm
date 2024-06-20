//
//  UserManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 20.06.2024.
//

import Foundation
import Combine

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    func register(info: RegisterInfo) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getRegisterURL(),
            data: info,
            requestType: .post
        )
    }
}
