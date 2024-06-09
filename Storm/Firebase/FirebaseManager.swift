//
//  FirebaseManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class FirebaseManager: NSObject {
    let firestore: Firestore
    let auth: Auth
    let storage: Storage
    static let shared = FirebaseManager()
    
    override init() {
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.storage = Storage.storage(url: storageUrl)
        super.init()
    }
}
