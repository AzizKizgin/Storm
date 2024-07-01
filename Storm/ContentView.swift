//
//  ContentView.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var user: [User]
    var body: some View {
        NavigationStack {
            if !user.isEmpty {
                HomeView()
            }
            else {
                StartView()
            }
        }
    }
}

#Preview {
    ContentView()
}
