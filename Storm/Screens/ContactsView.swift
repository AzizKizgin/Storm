//
//  ContactsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI

struct ContactsView: View {
    @Environment(\.undoManager) private var undo
    @State private var selectedUser: UserResponse?
    @Namespace var namespace
    @State private var users: [UserResponse] = [dummyUserResponse, dummyUserResponse2, dummyUserResponse3]
    var body: some View {
        List {
            ForEach(users, id: \.id){ user in
                ContactItem(user: user, onItemPress: {}, onImagePress: {selectedUser = user})
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                    .listRowBackground(Color.main)
                    .listRowSeparator(.hidden)
                    .swipeActions(allowsFullSwipe: false) {
                          Button(role: .destructive) {
                              print("Deleting conversation")
                          } label: {
                              Label("Delete", systemImage: "trash.fill")
                          }
                      }
            }
        }
        .navigationTitle("Contacts")
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(.main)
        .modal(isPresented: .constant(selectedUser != nil), onClose: {
            selectedUser = nil
        }) {
            if let selectedUser {
                ContactModalItem(contact: selectedUser)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
