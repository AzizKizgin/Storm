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
    
    func changeUsername(data: UpdateUsernameData) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getUpdateUsernameURL(),
            data: data,
            requestType: .put
        )
    }
    
    func changeUserAbout(data: UpdateUserAboutData) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getUpdateUserAboutURL(),
            data: data,
            requestType: .put
        )
    }
    
    func changeUserImage(data: UpdateUserImageData) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getUpdateProfilePictureURL(),
            data: data,
            requestType: .put
        )
    }
    
    func updateUserLastSeen() -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getUpdateLastSeenURL(),
            requestType: .put
        )
    }
}
