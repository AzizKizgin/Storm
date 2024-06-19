//
//  LoginView.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Spacer()
            TopMessage(title: "Register", message: "Good to see you! Please log in.")
            Spacer()
            VStack(spacing: 75) {
                VStack(spacing: 32){
                    FormInput("email", text: $email, type: .email)
                    FormInput("password", text: $password, type: .password)
                }
                .padding(.horizontal)
                VStack(spacing: 16) {
                    FormButton("Sign in", onPress: {})
                    NavigationLink("Forgot password?", destination: ForgotPasswordView())
                }
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
        LoginView()
    }
}
