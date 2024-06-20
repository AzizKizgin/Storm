//
//  FirebaseManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class FirebaseManager: NSObject {
    let firestore: Firestore
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        
        super.init()
    }
}
