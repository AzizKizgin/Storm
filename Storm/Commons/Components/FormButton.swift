//
//  FormButton.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct FormButton: View {
    let title: LocalizedStringKey
    let onPress: () -> Void
    var light: Bool
    
    init(_ title: LocalizedStringKey, onPress: @escaping () -> Void, light: Bool = false) {
        self.title = title
        self.onPress = onPress
        self.light = light
    }
    
    var body: some View {
        Button(action: onPress, label: {
            Text(title)
                .padding(8)
                .frame(width: 240)
        })
        .buttonStyle(BorderedProminentButtonStyle())
        .clipShape(RoundedRectangle(cornerRadius: .greatestFiniteMagnitude))
        .shadow(color: .accentColor,radius: 5)
        .tint(light ? .lightButton : .accent)
        .foregroundStyle(light ? .accent: .white)
    }
}

#Preview {
    FormButton("Sign in", onPress: {})
}
