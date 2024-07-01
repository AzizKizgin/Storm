//
//  ContactDataManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 1.07.2024.
//

import Foundation
import Combine

class ContactDataManager {
    static let shared = ContactDataManager()
    private init() {}
    
    func searchUsers(query: SearchUsersQuery) -> AnyPublisher<SearchUsersResponse, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getSearchUsersURL(query: query),
            requestType: .get
        )
    }
}
