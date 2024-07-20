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
    @Bindable private var contactsVM = ContactsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if contactsVM.isListLoading {
                    ProgressView()
                        .controlSize(.extraLarge)
                        .tint(.accent)
                }
                else if !contactsVM.contacts.isEmpty {
                    List(contactsVM.searchText.isEmpty ? contactsVM.contacts : contactsVM.filteredContacts, id: \.id){ contact in
                        ContactItem(user: contact.contactUser)
                            .onPress {
                                contactsVM.selectedContact = contact
                            }
                            .onRemoveContact {
                                contactsVM.showRemoveContactAlert(contact: contact)
                            }
                            .isCurrentUser(appUser.first?.id == contact.contactUser.id)
                            .id(contact.id)
                            .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                            .listRowBackground(Color.main)
                            .listRowSeparator(.hidden)
                        
                    }
                    .refreshable {
                        self.contactsVM.getContacts()
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(item: $contactsVM.selectedContact){ contact in
                        Text("\(contact.contactUser.id)")
                    }
                }
                else if !self.contactsVM.isListLoading {
                    EmptyListMessage(message: "Add your first contact", icon: "person.crop.circle.fill.badge.plus")
                        .onAppear {
                            self.contactsVM.getContacts()
                        }
                }
            }
            .searchable(text: $contactsVM.searchText)
            .onChange(of: contactsVM.searchText, { _ , _ in
                contactsVM.search()
            })
            .alert(self.contactsVM.errorMessage, isPresented: self.$contactsVM.showError) {
                Button("Ok") {}
            }
            .alert("Remove Contact", isPresented: $contactsVM.showRemoveAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Remove", role: .destructive) {
                    self.contactsVM.removeContact()
                }
            } message: {
                if let username = self.contactsVM.removingContact?.contactUser.username {
                    Text("Are you sure to remove \(username) from contacts")
                }
            }
            .navigationTitle("Contacts")
            .navigationDestination(isPresented: $contactsVM.showAddContactScreen) {
                AddContactsView()
            }
            .overlay(alignment: .bottomTrailing) {
                FloatingActionButton(onPress: {contactsVM.showAddContactScreen.toggle()})
                    .safeAreaPadding()
            }
            .background(.main)
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
