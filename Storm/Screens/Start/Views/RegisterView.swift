//
//  RegisterView.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct RegisterView: View {
    @Bindable private var authenticationVM = AuthenticationViewModel()
    var body: some View {
        VStack {
            TopMessage(title: "Register", message: "Sign up and start connecting!")
            Spacer()
            VStack(spacing: 75) {
                VStack(spacing: 32){
                    FormInput("username", text: $authenticationVM.registerInfo.username)
                    FormInput("email", text: $authenticationVM.registerInfo.email, type: .email)
                    FormInput("password", text: $authenticationVM.registerInfo.password, type: .password)
                    FormInput("confirm password", text: $authenticationVM.registerInfo.confirmPassword, type: .password)
                    CheckBox(isChecked: $authenticationVM.isChecked, title: "I agree with terms and conditions")
                        .underline()
                }
                .padding(.horizontal)
                FormButton("Sign up", onPress: authenticationVM.register)
            }
            .alert(authenticationVM.errorMessage, isPresented: $authenticationVM.showError){
                Button("Okay", role: .cancel) {}
            }
            .alert(authenticationVM.successMessage, isPresented: $authenticationVM.showSuccess){
                // TODO: - redirection must be added
                Button("Okay", role: .cancel) {}
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
