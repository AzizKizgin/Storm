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
            Text(Utils.formatDate(message.createdAt))
                .font(.caption)
                .frame(minWidth: 70, alignment: .trailing)
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
