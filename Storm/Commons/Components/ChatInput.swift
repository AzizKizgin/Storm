//
//  ChatInput.swift
//  Storm
//
//  Created by Aziz Kızgın on 25.07.2024.
//

import SwiftUI

struct ChatInput: View {
    @Binding var text: String
    let onSubmit: () -> Void
    var body: some View {
        HStack {
            TextField("Message...", text: $text, axis: .vertical)
                .frame(height: 20)
                .lineLimit(5)
                .padding(8)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundStyle(.lightMain)
                }
                
            Button {
                onSubmit()
                text = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .rotationEffect(.degrees(45))
                    .padding(4)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .clipShape(Circle())
            .tint(.accent)
            .disabled(text.isEmpty)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChatInput(text: .constant(""), onSubmit: {})
}
