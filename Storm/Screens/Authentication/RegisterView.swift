//
//  RegisterView.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var isChecked: Bool = false
    var body: some View {
        VStack {
            TopMessage(title: "Register", message: "Sign up and start connecting!")
            Spacer()
            VStack(spacing: 75) {
                VStack(spacing: 32){
                    FormInput("username", text: $username)
                    FormInput("email", text: $email, type: .email)
                    FormInput("password", text: $password, type: .password)
                    FormInput("confirm password", text: $password, type: .password)
                    CheckBox(isChecked: $isChecked, title: "I agree with terms and conditions")
                        .underline()
                }
                .padding(.horizontal)
                FormButton("Sign up", onPress: {})
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.main)
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}
