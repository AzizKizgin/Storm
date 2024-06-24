//
//  SettingsItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct SettingsItem: View {
    let icon: String
    let title: LocalizedStringKey
    let label: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .font(.title3)
            VStack {
                Text(title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.secondary)
                Text(label)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.primary)
            }
            .lineLimit(1)
            Image(systemName: "pencil")
                .foregroundStyle(.accent)
                .font(.title3)
        }
    }
}

#Preview {
    SettingsItem(icon: "person", title: "Name", label: "User name")
}
