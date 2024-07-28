//
//  Message.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI

struct MessageItem: View {
    let screenSize = UIScreen.main.bounds
    let message: Message
    let currentUserId: String
    var body: some View {
        HStack {
            if message.sender.id == currentUserId {
                TimeInfoText(message: message, currentUserId: currentUserId)
            }
            VStack(alignment: .trailing ,spacing: 0) {
                Text(message.content)
                    .frame(minWidth: 50)
            }
            .padding(.horizontal,10)
            .padding(.vertical,6)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.lightMain)
            }
            if message.sender.id != currentUserId {
                TimeInfoText(message: message, currentUserId: currentUserId)
            }

        }
        .contentShape(.rect)
    }
}


struct TimeInfoText: View {
    let message: Message
    let currentUserId: String
    var body: some View {
        HStack(spacing: 0) {
            Text(Utils.getChatDate(message.createdAt))
                .font(.caption)
            if message.sender.id == currentUserId {
                Image("check")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundStyle(
                        message.readBy.count == 2 ? .check: .gray
                    )
            }
        }
    }
}
#Preview {
    MessageItem(message: dummyMessage4, currentUserId: "userId")
}
