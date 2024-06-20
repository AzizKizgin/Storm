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
    let isLoading: Bool
    var light: Bool
    
    init(_ title: LocalizedStringKey, onPress: @escaping () -> Void, isLoading: Bool = false,  light: Bool = false) {
        self.title = title
        self.onPress = onPress
        self.isLoading = isLoading
        self.light = light
    }
    
    var body: some View {
        Button(action: !isLoading ? onPress: {}, label: {
            if !isLoading {
                Text(title)
                    .padding(8)
                    .frame(width: 240)
            } 
            else {
                ProgressView()
                    .imageScale(.large)
                    .padding(8)
                    .frame(width: 240)
                    .tint(.main)
            }
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
