//
//  Message.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI

struct MessageItem: View {
    let currentUserId: String = "userId"
    let screenSize = UIScreen.main.bounds
    let message: Message
    var body: some View {
        VStack(alignment: .trailing ,spacing: 0) {
            Text(message.content)
                .frame(minWidth: 70, alignment: .leading)
            HStack {
                Text(Utils.getMessageTime(message.createdAt))
                    .font(.caption)
                    .frame(minWidth: 70, alignment: .trailing)
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
        .padding(.horizontal,10)
        .padding(.vertical,4)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(.lightMain)
        }
        .contentShape(.rect)
        .padding(message.sender.id == currentUserId ? .leading: .trailing,UIScreen.main.bounds.width / 7)
    }
}

#Preview {
    ChatView()
}
