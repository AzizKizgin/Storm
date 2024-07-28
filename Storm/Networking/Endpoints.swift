//
//  Endpoints.swift
//  Storm
//
//  Created by Aziz Kızgın on 19.06.2024.
//

import Foundation

enum Endpoints {
    private static let baseURL = "http://localhost:5117/api"
    private static let userURL = "\(baseURL)/user"
    private static let contactURL = "\(baseURL)/contact"
    private static let chatURL = "\(baseURL)/chat"
    
    public static let websocketURL = "http://localhost:5117/chatHub"
    
    public static func getWebsocketURL() -> URL {
        let url = URL(string: websocketURL)!
        return url
    }
    
    // MARK: - User URLs
    public static func getRegisterURL() -> URL {
        let urlString = "\(userURL)/register"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getLoginURL() -> URL {
        let urlString = "\(userURL)/login"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getLogoutURL() -> URL {
        let urlString = "\(userURL)/logout"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getUpdateUsernameURL() -> URL {
        let urlString = "\(userURL)/update-username"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getUpdateProfilePictureURL() -> URL {
        let urlString = "\(userURL)/update-profile-picture"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getUpdateUserAboutURL() -> URL {
        let urlString = "\(userURL)/update-user-about"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getDeleteUserURL() -> URL {
        let urlString = "\(userURL)/delete-user"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getUpdateLastSeenURL() -> URL {
        let urlString = "\(userURL)/update-user-last-seen"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getSearchUsersURL(query: SearchUsersQuery?) -> URL {
        var urlComponent = URLComponents(string: "\(userURL)/search-users")!
        urlComponent.queryItems = query?.toQueryItems()
        return urlComponent.url!
    }
    
    public static func getUserById(id: String) -> URL {
        let urlString = "\(userURL)/get-user/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    // MARK: - Contact URLs
    
    public static func addContact() -> URL {
        let urlString = "\(contactURL)/create"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getAllContact() -> URL {
        let urlString = "\(contactURL)/get-all"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func removeContact(contactId: Int) -> URL {
        let urlString = "\(contactURL)/remove/\(contactId)"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func removeContact(contactUserId: String) -> URL {
        let urlString = "\(contactURL)/removeByUserId/\(contactUserId)"
        let url = URL(string: urlString)!
        return url
    }
    
    // MARK: - Chat URLs
    public static func getAllChats() -> URL {
        let urlString = "\(chatURL)/get-all"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func getChat(id: String) -> URL {
        let urlString = "\(chatURL)/get/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func readChat(id: String) -> URL {
        let urlString = "\(chatURL)/read/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func sendMessage() -> URL {
        let urlString = "\(chatURL)/send"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func deleteMessage(id: Int) -> URL {
        let urlString = "\(chatURL)/delete/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func editMessage(id: Int) -> URL {
        let urlString = "\(chatURL)/edit/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func reactMessage(id: Int) -> URL {
        let urlString = "\(chatURL)/react/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
    public static func unReactMessage(id: Int) -> URL {
        let urlString = "\(chatURL)/unreact/\(id)"
        let url = URL(string: urlString)!
        return url
    }
    
}
