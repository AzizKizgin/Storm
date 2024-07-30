//
//  ChatListView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI
import SwiftData

struct ChatListView: View {
    @Query private var user: [User]
    @Bindable private var chatListVM = ChatListViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if chatListVM.chats.isEmpty {
                    EmptyListMessage(message: "No message yet", icon: "text.bubble.fill")
                }
                else {
                    List(chatListVM.searchText.isEmpty ? chatListVM.chats : chatListVM.filteredChats,id: \.id) { chat in
                        let index = chatListVM.selectedChats.firstIndex(of: chat.id)
                        ChatItem(chat: chat, appUserId: user.first?.id ?? "")
                            .onPress {
                                withAnimation(.bouncy) {
                                    chatListVM.chatForNavigation = chat.id
                                }
                            }
                            .isSelected(index != nil)
                            .id(chat.id)
                            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .listRowBackground(chatListVM.selectedChats.contains(chat.id) ? Color.accent.opacity(0.5) : Color.main)
                            .listRowSeparator(.hidden)
                    }
                    .refreshable {
                        
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(item: $chatListVM.chatForNavigation){ chatId in
                        ChatView(chatId: chatId)
                    }
                }
            }
            .onAppear {
                Task {
                    chatListVM.onAppear()
                    chatListVM.appUserId = user.first?.id ?? ""
                    await chatListVM.getAllChats()
                }
            }
            .onDisappear {
                chatListVM.disAppear()
            }
            .alert(self.chatListVM.errorMessage, isPresented: self.$chatListVM.showError) {
                Button("Ok") {}
            }
            .safeAreaInset(edge: .top, content: {
                ChatListHeader(selectedChats: $chatListVM.selectedChats)
                    
            })
            .navigationDestination(isPresented: $chatListVM.showSelectContact) {
                SelectContactView()
            }
            .overlay(alignment: .bottomTrailing) {
                FloatingActionButton(icon: "text.bubble.fill"){
                    chatListVM.showSelectContact.toggle()
                }
                .safeAreaPadding()
            }
            .background(.main)
        }
    }
}

#Preview {
    NavigationStack {
        ChatListView()
    }
}
