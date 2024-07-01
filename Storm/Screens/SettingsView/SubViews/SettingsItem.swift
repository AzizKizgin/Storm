//
//  SettingsItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct SettingsItem: View {
    @State private var isPresented: Bool = false
    @State private var text = ""
    let label: String
    let type: SettingsInfoType
    let onChange: (String) -> Void
    
    init(label: String, type: SettingsInfoType, onChange: @escaping (String) -> Void) {
        self.text = label
        self.label = label
        self.type = type
        self.onChange = onChange
    }
    
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
        .sheet(isPresented: $isPresented, onDismiss: {text = label}){
            SettingsTextField(type.title, text: $text, maxSize: type.maxSize, onSave: { text in
                onChange(text)
                isPresented.toggle()
            }, onCancel: {isPresented.toggle()})
            .padding()
            .presentationDetents([.fraction(0.2)])
        }
        
    }
}

#Preview {
    SettingsItem(label: "username", type: .username, onChange: {_ in })
}
