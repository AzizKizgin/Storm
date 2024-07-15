//
//  ContactList.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import SwiftUI
import SwiftData

struct ContactList: View {
    @State private var selectedUser: UserResponse?
    @Query private var appUser: [User]
    let users: [UserResponse]?
    var onDelete: (() -> Void)? = nil
    var emptyListMessage: LocalizedStringKey = ""
    var emptyListIcon: String = ""
    var body: some View {
        VStack {
            if let users = users, !users.isEmpty {
                List {
                    ForEach(users, id: \.id){ user in
                        ContactItem(user: user, onItemPress: {}, onImagePress: {selectedUser = user},isCurrentUser: appUser.first?.id == user.id)
                            .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                            .listRowBackground(Color.main)
                            .listRowSeparator(.hidden)
                            .swipeActions(allowsFullSwipe: false) {
                                if let onDelete {
                                    Button(role: .destructive) {
                                        onDelete()
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                            }
                    }
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
            }
            else {
                EmptyListMessage(message: emptyListMessage, icon: emptyListIcon)
            }
        }
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

extension ContactList {
    func emptyListMessage(_ message: LocalizedStringKey, icon: String = "") ->  ContactList  {
        var copy = self
        copy.emptyListMessage = message
        copy.emptyListIcon = icon
        return copy
    }
    
    func onDelete(_ delete: @escaping () -> Void) -> ContactList {
        var copy = self
        copy.onDelete = delete
        return copy
    }
}

#Preview {
    ContactList(users: [dummyUserResponse, dummyUserResponse2, dummyUserResponse3])
}
