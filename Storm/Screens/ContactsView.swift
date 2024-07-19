//
//  ContactsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI
import SwiftData

struct ContactsView: View {
    @Query private var appUser: [User]
    @State private var showAddContacts: Bool = false
    @State private var users: [UserResponse]?
    @State private var selectedUser: UserResponse?
    var body: some View {
        VStack {
            if let users = users, !users.isEmpty {
                List {
                    ForEach(users, id: \.id){ user in
                        ContactItem(user: user)
                            .onPress {
                                selectedUser = user
                            }
                            .isCurrentUser(appUser.first?.id == user.id)
                            .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                            .listRowBackground(Color.main)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
            }
            else {
                EmptyListMessage(message: "You have no contact yet", icon: "person.crop.circle.fill.badge.plus")
            }
        }
        .onAppear {
            users = [dummyUserResponse, dummyUserResponse2, dummyUserResponse3]
        }
        .background(.main)
        .navigationTitle("Contacts")
        .navigationDestination(item: $selectedUser){ user in
            Text(user.id)
        }
        .navigationDestination(isPresented: $showAddContacts) {
            AddContactsView()
        }
        .background(.main)
        .overlay(alignment: .bottomTrailing) {
            FloatingActionButton(onPress: {showAddContacts.toggle()})
                .safeAreaPadding()
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
