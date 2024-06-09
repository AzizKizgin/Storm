//
//  Contacts.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import FirebaseFirestore

struct Contact: Codable {
    @DocumentID var id: String?
    var name: String
    var profilePictureUrl: String
}
