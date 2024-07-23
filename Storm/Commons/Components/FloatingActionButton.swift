//
//  FloatingActionButton.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import SwiftUI

struct FloatingActionButton: View {
    var icon: String = ""
    let onPress: () -> Void
    var body: some View {
        Button {
            onPress()
        } label: {
            Circle()
                .frame(width: 60)
                .overlay {
                    Image(systemName: icon.isEmpty ? "plus": icon)
                        .font(.title)
                        .foregroundStyle(.main)
                }
        }
    }
}

#Preview {
    FloatingActionButton(onPress: {})
}
