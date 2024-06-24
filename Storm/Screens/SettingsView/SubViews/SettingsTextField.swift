//
//  SettingsTextField.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct SettingsTextField: View {
    @State private var textState: String = ""
    let title: LocalizedStringKey
    @Binding var text: String
    let maxSize: Int
    let onSave: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.accent)
            FormInput(title, text: $textState)
                .onChange(of: textState) { _ , newValue in
                    if newValue.count > maxSize {
                        textState = String(newValue.prefix(maxSize))
                    }
                }
                .overlay(alignment: .trailing) {
                    Text("\(maxSize-textState.count)")
                }
            HStack(spacing: 32) {
                Button(action: onCancel, label: {
                    Text("Cancel")
                })
                Button(action: onSave, label: {
                    Text("Save")
                })
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .onAppear {
                textState = text
            }
        }
    }
}

#Preview {
    SettingsTextField(title: "Username", text: .constant("User name"), maxSize: 20, onSave: {}, onCancel: {})
}
