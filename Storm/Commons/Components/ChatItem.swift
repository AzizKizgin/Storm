//
//  ChatItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import SwiftUI

struct ChatItem: View {
    @State private var showModal: Bool = false
    @State private var showIcon: Bool = false
    private let chat: Chat
    private let user: ChatMember?
    let contact: UserResponse
    var onItemPress: () -> Void = {}
    var onLongPress: () -> Void = {}
    var isSelected: Bool = false
    
    init(chat: Chat, appUserId: String) {
        self.chat = chat
        self.contact = chat.members.first{$0.user.id != appUserId}!.user
        self.user = chat.members.first{$0.user.id == appUserId}
    }
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            UserImage(userImage: contact.profilePicture ?? "",size: 50)
                .onChange(of: isSelected, { oldValue, newValue in
                    withAnimation {
                        showIcon = newValue
                    }
                })
                .transition(.slide)
                .overlay(alignment: .bottomTrailing){
                    if showIcon {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.check)
                            .padding(1)
                            .background{
                                Circle()
                                    .fill(.main)
                            }
                            .padding(-3)
                            .transition(.scale)
                    }
                }
                .onTapGesture {
                    if !isSelected {
                        UIView.setAnimationsEnabled(false)
                        showModal.toggle()
                    }
                    else {
                        onItemPress()
                    }
                }
            VStack(spacing: 6) {
                HStack() {
                    Text(contact.username)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text(Utils.getChatDate(chat.messages.last?.createdAt ?? ""))
                        .font(.caption)
                }
                HStack {
                    if let message = chat.messages.last {
                        HStack(spacing: 3) {
                            if message.sender.id == user?.user.id {
                                Image("check")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .foregroundStyle(
                                        message.readBy.contains(contact.id) ? .check: .gray
                                    )
                            }
                            Text(message.content)
                                .frame(maxWidth: .infinity, alignment: .leading)
                   
                        }
                        .opacity(
                            !message.readBy.contains(user?.user.id ?? "")
                            ? 1: 0.6)
                        .lineLimit(1)
                    }
                    Spacer()
                    if let user {
                        HStack {
                            let unReadMessageCount = chat.messages.filter{!$0.readBy.contains(user.user.id)}.count
                            if unReadMessageCount > 0 {
                                Text("\(unReadMessageCount)")
                                    .foregroundStyle(.white)
                                    .frame(width: 20)
                                    .bold()
                                    .background {
                                        Circle()
                                            .fill(.accent)
                                    }
                            }
                            if user.isMuted {
                                Image(systemName: "bell.slash.fill")
                                    .foregroundStyle(.accent)
                            }
                            if user.isPinned {
                                Image(systemName: "pin.fill")
                                    .foregroundStyle(.accent)
                            }
                        }
                    }
                }
            }
            
        }
        .contentShape(.rect)
        .onTapGesture {
            onItemPress()
        }
        .onLongPressGesture(minimumDuration: 0.1){
            onLongPress()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 75)
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
                ContactModalItem(contact: contact)
            }
            .presentationBackground(.clear)
        }
    }
}

extension ChatItem {
    func onPress(_ onPress: @escaping () -> Void) -> ChatItem {
        var copy = self
        copy.onItemPress = onPress
        return copy
    }
    
    func onLongPress(_ onPress: @escaping () -> Void) -> ChatItem {
        var copy = self
        copy.onLongPress = onPress
        return copy
    }
    
    func isSelected(_ selected: Bool) -> ChatItem {
        var copy = self
        copy.isSelected = selected
        return copy
    }
}

#Preview {
    ChatItem(chat: dummyChatList[0], appUserId: "userId")
        .onPress {
            print("press")
        }
        .onLongPress {
            print("long")
        }
}
