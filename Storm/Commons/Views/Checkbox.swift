//
//  Checkbox.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import SwiftUI

struct CheckBox: View {
    @Binding var isChecked: Bool
    let title: LocalizedStringKey
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill": "square")
                .foregroundStyle(isChecked ? .accent: .focus)
                .onTapGesture {
                    isChecked.toggle()
                }
                .font(.title3)
            Text(title)
                .foregroundStyle(.accent)
        }
    }
}

#Preview {
    CheckBox(isChecked: .constant(false), title: "Remember me")
}

