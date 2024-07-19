//
//  AddContactsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import SwiftUI
import SwiftData

struct AddContactsView: View {
    @Bindable private var addContactsVM = AddContactsViewModel()
    @Query private var appUser: [User]
    
    var body: some View {
        VStack {
            if !addContactsVM.searchResult.users.isEmpty {
                List {
                    ForEach(addContactsVM.searchResult.users, id: \.id){ user in
                        ContactItem(user: user)
                            .onPress {
                                addContactsVM.selectedUser = user
                            }
                            .onAddContact {
                                addContactsVM.addContact(id: user.id)
                            }
                            .onRemoveContact {
                                addContactsVM.showRemoveContactAlert(contact: user)
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
                if addContactsVM.searchObject.username.isEmpty {
                    EmptyListMessage(message: "Start searching for contacts", icon: "magnifyingglass.circle.fill")
                }
                else {
                    EmptyListMessage(message: "No user found", icon: "exclamationmark.circle.fill")
                }
            }
        }
        .alert("Remove Contact", isPresented: $addContactsVM.showRemoveAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Remove", role: .destructive) {
                self.addContactsVM.removeContact()
            }
        } message: {
            if let username = self.addContactsVM.removingContact?.username {
                Text("Are you sure to remove \(username) from contacts")
            }
        }
        .searchable(text: $addContactsVM.searchObject.username)
        .onChange(of: addContactsVM.searchObject.username, { oldValue, newValue in
            addContactsVM.searchUsers()
        })
        .navigationTitle("Add Contact")
        .navigationDestination(item: $addContactsVM.selectedUser){ user in
            Text(user.id)
        }
        .background(.main)
    }
}

#Preview {
    NavigationStack {
        AddContactsView()
    }
}
