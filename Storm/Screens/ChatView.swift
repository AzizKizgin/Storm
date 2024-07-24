//
//  ChatView.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    @State private var currentMessageDate: String = ""
    @State private var chat: Chat = dummyChatList[0]
    var body: some View {
        let contact = chat.members.first{$0.user.id != "userId"}
        VStack {
            ScrollViewReader { proxy in
                List(chat.messages,id: \.id) { message in
                    Group {
                        VStack {
                            if message == chat.messages.first {
                                DateTitle(date: message.createdAt)
                            }
                            else if let index = chat.messages.firstIndex(of: message),
                                    Utils.getDayDate(chat.messages[index - 1].createdAt) != Utils.getDayDate(message.createdAt)
                            {
                                DateTitle(date: message.createdAt)
                            }
                            
                        }
                        .listRowBackground( Color.main)
                        MessageItem(message: message)
                            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .listRowBackground( Color.main)
                            .listRowSeparator(.hidden)
                            .id(message.id)
                    }
                }
                .onAppear {
                    if let lastItem = chat.messages.first(where: {!$0.readBy.contains("userId")})?.id {
                        proxy.scrollTo(lastItem, anchor: .top)
                    }
                    else if let lastItem = chat.messages.last?.id {
                        proxy.scrollTo(lastItem, anchor: .top)
                    }
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
            }
            ChatInput(text: $text) {
                
            }
        }
        .background(.main)
        .safeAreaInset(edge: .top) {
            ChatHeader(user: contact?.user, onPress: {dismiss()})
        }
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}

struct DateTitle: View {
    let date: String
    var body: some View {
        Text(Utils.getDateTitle(date))
            .padding(.vertical,2)
            .frame(width: 100)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.lightMain)
            }
            .frame(maxWidth: .infinity)
    }
}
