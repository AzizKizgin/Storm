//
//  AddMessageView.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI

struct SelectContactView: View {
    @Bindable private var selectContactVM = SelectContactViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectContactVM.isLoading {
                    ProgressView()
                        .controlSize(.extraLarge)
                        .tint(.accent)
                }
                else if !selectContactVM.contacts.isEmpty {
                    List(selectContactVM.searchText.isEmpty ? selectContactVM.contacts : selectContactVM.filteredContacts, id: \.id){ contact in
                        SelectContactItem(user: contact.contactUser)
                            .onPress {
                                selectContactVM.selectedContact = contact.contactUser
                            }
                            .id(contact.id)
                            .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                            .listRowBackground(Color.main)
                            .listRowSeparator(.hidden)
                        
                    }
                    .refreshable {
                        self.selectContactVM.getContacts()
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(item: $selectContactVM.selectedContact){ user in
                        ChatView(contact: user)
                    }
                }
                else if !self.selectContactVM.isLoading {
                    EmptyListMessage(message: "No contacts found", icon: "person.crop.circle.fill.badge.plus")
                }
            }
            .onAppear {
                self.selectContactVM.getContacts()
            }
            .searchable(text: $selectContactVM.searchText)
            .onChange(of: selectContactVM.searchText, { _ , _ in
                selectContactVM.search()
            })
            .alert(self.selectContactVM.errorMessage, isPresented: self.$selectContactVM.showError) {
                Button("Ok") {}
            }
            .navigationTitle("Select Contact")
            .background(.main)
        }
    }
}

#Preview {
    NavigationStack {
        SelectContactView()
    }
}
