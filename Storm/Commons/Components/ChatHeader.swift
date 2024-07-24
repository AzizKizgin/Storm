//
//  ChatHeader.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI

struct ChatHeader: View {
    let user: UserResponse?
    let onPress: () -> Void
    var body: some View {
        HStack(spacing: 5) {
            Button(action: onPress, label: {
                Image(systemName: "arrow.backward")
                    .font(.title3)
                UserImage(userImage: user?.profilePicture ?? "", size: 40)
            })
            Text(user?.username ?? "Storm User")
                .font(.title2)
                .bold()
                .padding(.horizontal, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.accent)
        .padding(.bottom)
        .padding(.horizontal)
        .background(.lightMain)
    }
}

#Preview {
    ChatHeader(user: dummyUserResponse, onPress: {})
}
