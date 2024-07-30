//
//  ChatView.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @Query private var user: [User]
    @Environment(\.dismiss) private var dismiss
    @Bindable private var chatVM = ChatViewModel()
    var chatId: String? = nil
    var contact: UserResponse? = nil
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    if !chatVM.messages.isEmpty {
                        List(chatVM.messages,id: \.id) { message in
                            HStack {
                                if message.sender.id == user.first?.id {
                                    Spacer()
                                }
                                MessageItem(message: message,currentUserId: user.first?.id ?? "")
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .listRowBackground( Color.main)
                            .listRowSeparator(.hidden)
                            .id(message.id)
                        }
                        .onChange(of: self.chatVM.messages, { oldValue, newValue in
                            if newValue.count > oldValue.count, let lastItem = chatVM.messages.last?.id {
                                proxy.scrollTo(lastItem, anchor: .top)
                            }
                            chatVM.readChat()
                        })
                        .onAppear {
                            if let readLastItem = chatVM.messages.first(where: {!$0.readBy.contains(user.first?.id ?? "")})?.id {
                                proxy.scrollTo(readLastItem, anchor: .top)
                            }
                            else if let lastItem = chatVM.messages.last?.id {
                                proxy.scrollTo(lastItem, anchor: .top)
                            }
                            chatVM.readChat()
                        }
                        .listStyle(.inset)
                        .scrollContentBackground(.hidden)
                    }
                    else {
                        VStack {}
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                ChatInput(text: $chatVM.content) {
                    chatVM.sendMessage()
                }
            }
            .onAppear {
                chatVM.onAppear(contact: contact, chatId: chatId, appUserId: user.first?.id)
            }
            .background(.main)
            .safeAreaInset(edge: .top) {
                ChatHeader(user: chatVM.contact, onPress: {dismiss()})
            }
            .navigationBarBackButtonHidden()
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
