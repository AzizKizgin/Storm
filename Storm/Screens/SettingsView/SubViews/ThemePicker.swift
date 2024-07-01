//
//  ThemeToggle.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ThemePicker: View {
    @AppStorage("isDark") private var isDark: Bool = false

    var body: some View {
        HStack {
            Picker(selection: $isDark) {
                Text("Light")
                    .tag(false)
                Text("Dark")
                    .tag(true)
            } label: {
                customLabel
            }
            .pickerStyle(.navigationLink)
            .foregroundStyle(.primary)
        }
    
    }
    
    var customLabel: some View {
        HStack(spacing: 16) {
            Image(systemName: "moonphase.first.quarter")
                .foregroundStyle(.secondary)
                .font(.title3)
            VStack {
                Text("Theme")
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ThemePicker()
    }
}
