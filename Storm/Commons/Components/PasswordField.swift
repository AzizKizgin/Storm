//
//  PasswordField.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import SwiftUI

struct PasswordField: View {
    @Binding var text: String
    var title: LocalizedStringKey
    @FocusState<Bool>.Binding var isFocused: Bool
    @State private var showContent: Bool = false
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(isFocused ? .focus : .accent)
                if showContent {
                    TextField(title, text: $text)
                        .focused($isFocused)
                }
                else {
                    SecureField(title, text: $text)
                        .focused($isFocused)
                }
                Button(action: {showContent.toggle()}, label: {
                    Image(systemName:showContent ? "eye": "eye.slash")
                        .foregroundColor(isFocused ? .focus : .accent)
                        .frame(height: 25)
                })
            }
            Rectangle()
                  .frame(height: 1)
                  .foregroundColor(isFocused ? .focus : .accent)
                  .padding(.top, 5)
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
}

#Preview {
    @State var text: String = ""
    @FocusState var isfocused
    return PasswordField(text: $text, title: "Password", isFocused: $isfocused)
}

