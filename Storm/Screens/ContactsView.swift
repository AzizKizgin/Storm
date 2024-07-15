//
//  ContactsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI

struct ContactsView: View {
    @State private var showAddContacts: Bool = false
    @State private var users: [UserResponse] = [dummyUserResponse, dummyUserResponse2, dummyUserResponse3]
    var body: some View {
        NavigationStack {
            ContactList(users: users)
                .emptyListMessage("Add your first contact now!",icon: "plus.circle.fill")
                .onDelete {
                    print("deleted")
                }
                .navigationDestination(isPresented: $showAddContacts) {
                    AddContactsView()
                }
        }
        .navigationTitle("Contacts")
        .background(.main)
        .overlay(alignment: .bottomTrailing) {
            FloatingActionButton(onPress: {showAddContacts.toggle()})
                .safeAreaPadding()
        }
  
    }
}

#Preview {
    ContactsView()
}
