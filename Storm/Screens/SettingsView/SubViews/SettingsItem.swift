//
//  SettingsItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct SettingsItem: View {
    @State private var isPresented: Bool = false
    @Binding var label: String
    let type: SettingsItemType
    let onChange: () -> Void
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: type.icon)
                .foregroundStyle(.secondary)
                .font(.title3)
            VStack {
                Text(type.title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.secondary)
                Text(label)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.primary)
            }
            .lineLimit(4)
            Image(systemName: "pencil")
                .foregroundStyle(.accent)
                .font(.title3)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented){
            SettingsTextField(title: type.title, text: $label, maxSize: type.maxSize, onSave: onChange, onCancel: {isPresented.toggle()})
            .padding()
            .presentationDetents([.fraction(0.2)])
        }
 
    }
}

#Preview {
    SettingsItem(label: .constant("username"), type: .username, onChange: {})
}
