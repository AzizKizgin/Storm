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
    @State private var showSplash: Bool = true
    @AppStorage("isDark") private var isDark: Bool = false
    var body: some View {
        Group {
            if showSplash {
                SplashScreen()
                    .transition(.scale)
            }
            else if !user.isEmpty {
                HomeView()
            }
            else {
                StartView()
            }
        }
        .preferredColorScheme(isDark ? .dark: .light)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.default) {
                    showSplash.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
