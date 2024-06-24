//
//  SettingsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var username = "user name"
    @State private var about = "user about"
    var body: some View {
        VStack(spacing: 20) {
            UserImage(userImage: userImagePlaceholder3)
                .padding()
            SettingsItem(label: $username, type: .username, onChange: {})
            SettingsItem(label: $about, type: .about, onChange: {})
            ThemeToggle()
            Spacer()
        }
        .padding()
        .background(.main)
    }
}


#Preview {
    NavigationStack {
        SettingsView()
    }
}
