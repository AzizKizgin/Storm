//
//  SettingsTextField.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct SettingsTextField: View {
    @Binding var text: String
    let title: LocalizedStringKey
    let maxSize: Int
    let onSave: (String) -> Void
    let onCancel: () -> Void
    
    init(_ title: LocalizedStringKey, text: Binding<String>, maxSize: Int, onSave: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        self._text = text
        self.title = title
        self.maxSize = maxSize
        self.onSave = onSave
        self.onCancel = onCancel
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.accent)
            FormInput(title, text: $text)
                .onChange(of: text) { _ , newValue in
                    if newValue.count > maxSize {
                        text = String(newValue.prefix(maxSize))
                    }
                }
                .overlay(alignment: .trailing) {
                    Text("\(maxSize-text.count)")
                }
            HStack(spacing: 32) {
                Button(action: onCancel, label: {
                    Text("Cancel")
                })
                Button(action: {onSave(text)}, label: {
                    Text("Save")
                })
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    SettingsTextField("username", text: .constant("User name"), maxSize: 25, onSave: {_ in }, onCancel: { })
}
