//
//  ContactItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 10.07.2024.
//

import SwiftUI

struct ContactItem: View {
    @State private var showModal: Bool = false
    let user: UserResponse
    var onItemPress: () -> Void = {}
    var onAddContact: () -> Void = {}
    var onRemoveContact: () -> Void = {}
    var isCurrentUser: Bool = false
    var isContact: Bool = false
    
    init(user: UserResponse) {
        self.user = user
    }
    var body: some View {
        HStack(spacing: 0){
            UserImage(userImage: user.profilePicture ?? "", size: 50)
                .padding(.trailing)
                .onTapGesture {
                    UIView.setAnimationsEnabled(false)
                    showModal.toggle()
                }
            VStack {
                Text(isCurrentUser ? "You" : user.username)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(isCurrentUser ? .accent : .primary)
                    .bold(isCurrentUser)
                Text(user.about)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
            }
            .lineLimit(1)
            Group {
                if !isCurrentUser {
                    if isContact {
                        Button(action: {}, label: {
                            Image(systemName: "person.fill.badge.minus")
                                .foregroundStyle(.accent)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    else {
                        Button(action: {}, label: {
                            Image(systemName: "person.fill.badge.plus")
                                .foregroundStyle(.accent)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .font(.title2)
        }
        .contentShape(.rect)
        .onTapGesture {
            onItemPress()
        }
        .padding(.horizontal)
        .background(.main)
        .fullScreenCover(isPresented: $showModal) {
            ZStack {
                Color.accent
                    .opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showModal.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            UIView.setAnimationsEnabled(true)
                        }
                    }
                ContactModalItem(contact: user)
            }
            .presentationBackground(.clear)
        }
    }
}

extension ContactItem {
    func onPress(_ onPress: @escaping () -> Void) -> ContactItem {
        var copy = self
        copy.onItemPress = onPress
        return copy
    }
    
    func onAddContact(_ onAddContact: @escaping () -> Void) -> ContactItem {
        var copy = self
        copy.onAddContact = onAddContact
        return copy
    }
    
    func onRemoveContact(_ onRemoveContact: @escaping () -> Void) -> ContactItem {
        var copy = self
        copy.onRemoveContact = onRemoveContact
        return copy
    }
    
    func isCurrentUser(_ isCurrentUser: Bool) -> ContactItem {
        var copy = self
        copy.isCurrentUser = isCurrentUser
        return copy
    }
    
    func isContact(_ isContact: Bool) -> ContactItem {
        var copy = self
        copy.isContact = isContact
        return copy
    }
    
}

#Preview {
    ContactItem(user: dummyUserResponse)
        .onPress {}
        .isContact(true)
}
