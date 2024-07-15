//
//  FloatingActionButton.swift
//  Storm
//
//  Created by Aziz Kızgın on 12.07.2024.
//

import SwiftUI

struct FloatingActionButton: View {
    let onPress: () -> Void
    var body: some View {
        Button {
            onPress()
        } label: {
            Circle()
                .frame(width: 60)
                .overlay {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(.main)
                }
        }
    }
}

#Preview {
    FloatingActionButton(onPress: {})
}
