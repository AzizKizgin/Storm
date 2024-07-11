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
    var body: some View {
        HStack(spacing: 0){
            UserImage(userImage: user.profilePicture ?? "", size: 50)
                .padding(.trailing)
                .onTapGesture {
                    onImagePress()
                }
            VStack {
                Text(user.username)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.primary)
                Text(user.about)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
            }
            Button(action: {}, label: {
                Image(systemName: "person.fill.badge.plus")
                    .foregroundStyle(.accent)
            })
            .buttonStyle(PlainButtonStyle())
            .lineLimit(1)
        }
        .padding(.horizontal)
        .background(.main)
    }
}

#Preview {
    ContactItem(user: dummyUserResponse, onItemPress: {}, onImagePress: {})
}
