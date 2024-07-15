//
//  EmptyListMessage.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import SwiftUI

struct EmptyListMessage: View {
    let message: LocalizedStringKey
    var icon: String = ""
    var body: some View {
        VStack(spacing:20) {
            Image(systemName: icon)
                .font(.largeTitle)
            Text(message)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.accent)
    }
}

#Preview {
    EmptyListMessage(message: "Add your first contact now!", icon: "magnifyingglass.circle.fill")
}
