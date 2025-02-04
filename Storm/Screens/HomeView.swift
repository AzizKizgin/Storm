//
//  HomeView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedTab: TabScreenType = .chatList
    var body: some View {
        TabView(selection: $selectedTab) {
            ChatListView()
                .tag(TabScreenType.chatList)
                .tabItem {
                    Label("Chats", systemImage: "text.bubble")
                }
            ContactsView()
                .tag(TabScreenType.contacts)
                .tabItem {
                    Label("Contacts", systemImage: "person.3")
                }
          
            SettingsView()
                .tag(TabScreenType.settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: User.self, configurations: config)
        container.mainContext.insert(dummyUser)
        
        return HomeView()
            .modelContainer(container)
        
    }
    
}
