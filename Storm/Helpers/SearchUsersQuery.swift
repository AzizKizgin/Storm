//
//  SearchUsersQuery.swift
//  Storm
//
//  Created by Aziz Kızgın on 1.07.2024.
//

import Foundation

struct SearchUsersQuery: Encodable, Equatable {
    var username: String = ""
    var page: Int = 1
    var pageSize: Int = 15
    
    func toQueryItems() -> [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        var queryItems = [URLQueryItem]()
        
        for case let (label?, value) in mirror.children {
            if let stringValue = value as? CustomStringConvertible {
                let stringRepresentation = stringValue.description
                queryItems.append(URLQueryItem(name: label, value: stringRepresentation))
            }
        }
        return queryItems
    }
}

