//
//  ForgotPasswordView.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    var body: some View {
        VStack(spacing: 100) {
            Spacer()
            TopMessage(title: "Forgot Password", message: "No worries, reset your password here.")
            VStack(spacing: 75) {
                VStack(spacing: 32){
                    FormInput("email", text: $email, type: .email)
                }
                .padding(.horizontal)
                VStack(spacing: 16) {
                    FormButton("Sign in", onPress: {})
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
    ForgotPasswordView()
}
