//
//  FormInput.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct FormInput: View {
    @Binding var text: String
    var title: LocalizedStringKey
    var type: FormInputType
    
    @FocusState private var isFocused
    
    init(_ title: LocalizedStringKey, text: Binding<String>, type: FormInputType = .username) {
        self._text = text
        self.title = title
        self.type = type
    }
    var body: some View {
        HStack {
            if type == .password {
                PasswordField(text: $text, title: title, isFocused: $isFocused)
                    .focused($isFocused)
            }
            else {
                VStack {
                    HStack {
                        Image(systemName: type == .username ? "person.fill": "envelope.fill")
                            .foregroundColor(isFocused ? .focus : .accent)
                        TextField(title, text: $text)
                            .keyboardType(type == .email ? .emailAddress : .default)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .focused($isFocused)
                            .frame(height: 25)
                    }
                    Rectangle()
                          .frame(height: 1)
                          .foregroundColor(isFocused ? .focus : .accent)
                          .padding(.top, 5)
                }
            }
        }
    }
}

#Preview {
    @State var text: String = "example@example.com"
    return FormInput("Email", text: $text, type: .password)
}
