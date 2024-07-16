//
//  AddContactsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import SwiftUI

struct AddContactsView: View {
    @Bindable private var addContactsVM = AddContactsViewModel()
    var body: some View {
        VStack {
      
        }
        .navigationTitle("Add Contact")
        .onAppear {
            //            addContactsVM.searchResult = dummySearchUsersResponse
        }
        .searchable(text: $addContactsVM.searchObject.username)
        .onChange(of: addContactsVM.searchObject.username) { _ , text in
            print(text) 
            addContactsVM.searchUsers()
        }
    }
}

#Preview {
    NavigationStack {
        AddContactsView()
    }
}
