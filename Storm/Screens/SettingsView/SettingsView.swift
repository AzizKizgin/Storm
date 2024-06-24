//
//  SettingsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 16) {
            UserImage(userImage: userImagePlaceholder3)
                .padding()
            SettingsItem(icon: "person", title: "Name", label: "User name")
            SettingsItem(icon: "info.circle", title: "About", label: "User about")
            SettingsItem(icon: "moonphase.first.quarter", title: "Theme", label: "Light")
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
