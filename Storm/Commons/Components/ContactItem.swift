//
//  ContactItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 10.07.2024.
//

import SwiftUI

struct ContactItem: View {
    let user: UserResponse
    let onItemPress: () -> Void
    let onImagePress: () -> Void
    var onAddPress: () -> Void = {}
    var isCurrentUser: Bool = false
    var body: some View {
        HStack(spacing: 0){
            UserImage(userImage: user.profilePicture ?? "", size: 50)
                .padding(.trailing)
                .onTapGesture {
                    onImagePress()
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
            if !isCurrentUser {
                Button(action: {}, label: {
                    Image(systemName: "person.fill.badge.plus")
                        .foregroundStyle(.accent)
                })
                .buttonStyle(PlainButtonStyle())
            }

        }
        .padding(.horizontal)
        .background(.main)
    }
}

#Preview {
    ContactItem(user: dummyUserResponse, onItemPress: {}, onImagePress: {}, isCurrentUser: true)
}
