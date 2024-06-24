//
//  ThemeToggle.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ThemeToggle: View {
    @AppStorage("isDark") private var isDark: Bool = false

    var body: some View {
        Toggle(isOn: $isDark, label: {
            customLabel
        })
    
    }
    
    var customLabel: some View {
        HStack(spacing: 16) {
            Image(systemName: "moonphase.first.quarter")
                .foregroundStyle(.secondary)
                .font(.title3)
            VStack {
                Text("Theme")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.secondary)
                Text(isDark ? "Dark": "Light")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    ThemeToggle()
}
