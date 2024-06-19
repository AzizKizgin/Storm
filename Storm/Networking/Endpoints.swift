//
//  Endpoints.swift
//  Storm
//
//  Created by Aziz Kızgın on 19.06.2024.
//

import Foundation

enum Endpoints {
    private static let baseURL = "http://localhost:5270/api"
    private static let userURL = "\(baseURL)/user"
    
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
    
    
}
