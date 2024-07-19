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
    
    func addContact(createContactInfo: CreateContactDto) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.addContact(),
            data: createContactInfo,
            requestType: .post
        )
    }
    
    func removeContact(contactId: String) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.removeContact(contactUserId: contactId),
            requestType: .delete
        )
    }
    
    func removeContact(contactId: Int) -> AnyPublisher<SuccessMessage, Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.removeContact(contactId: contactId),
            requestType: .delete
        )
    }
    
    func getAllContacts() -> AnyPublisher<[ContactResponse], Error> {
        return DataManager.shared.sendRequest(
            for: Endpoints.getAllContact(),
            requestType: .get
        )
    }
}
