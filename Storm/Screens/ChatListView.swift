//
//  ChatListView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI

struct ChatListView: View {
    @State var selectedChat: String?
    @State var selectedChats: [String] = []
    var body: some View {
        NavigationStack {
            List(dummyChatList,id: \.id) { chat in
                let index = selectedChats.firstIndex(of: chat.id)
                ChatItem(chat: chat, appUserId: "userId")
                    .onPress {
                        withAnimation(.bouncy) {
                            if let index {
                                selectedChats.remove(at: index)
                            }
                            else if !selectedChats.isEmpty {
                                selectedChats.append(chat.id)
                            }
                            else {
                                selectedChat = chat.id
                            }
                        }
                    }
                    .onLongPress {
                        withAnimation(.bouncy) {
                            selectedChats.append(chat.id)
                        }
                    }
                    .isSelected(index != nil)
                    .id(chat.id)
                    .listRowInsets(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .listRowBackground(selectedChats.contains(chat.id) ? Color.accent.opacity(0.5) : Color.main)
                    .listRowSeparator(.hidden)
            }
            .safeAreaInset(edge: .top, content: {
                ChatListHeader(selectedChats: $selectedChats)
                    
            })
            .refreshable {
                
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
            .navigationDestination(item: $selectedChat){ chat in
                Text("\(chat)")
            }
            .background(.main)
        }
    }
}

#Preview {
    ChatListView()
}
