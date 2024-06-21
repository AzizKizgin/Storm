//
//  LoginView.swift
//  Storm
//
//  Created by Aziz Kızgın on 9.06.2024.
//

import SwiftUI

@MainActor
struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable private var loginVM = LoginViewModel()
    var body: some View {
        VStack {
            Spacer()
            TopMessage(title: "Login", message: "Good to see you! Please log in.")
            Spacer()
            VStack(spacing: 75) {
                VStack(spacing: 32){
                    FormInput("email", text: $loginVM.loginInfo.email, type: .email)
                    FormInput("password", text: $loginVM.loginInfo.password, type: .password)
                }
                .padding(.horizontal)
                VStack(spacing: 16) {
                    FormButton("Sign in", onPress: loginVM.login, isLoading: loginVM.isLoading)
                    NavigationLink("Forgot password?", destination: ForgotPasswordView())
                }
            }
            Spacer()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.main)
        .onChange(of: loginVM.isSuccess) { _ , _ in
            if loginVM.isSuccess {
                dismiss()
            }
        }
        .alert(loginVM.errorMessage, isPresented: $loginVM.showError){
            Button("Okay", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
