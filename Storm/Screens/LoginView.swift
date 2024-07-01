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
    @Environment(\.modelContext) private var modelContext
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
                    FormButton("Sign in", onPress: self.onLogin, isLoading: self.loginVM.isLoading)
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

extension LoginView {
    private func onLogin() {
        loginVM.login { userResponse in
            if let userResponse {
                modelContext.insert(userResponse.toUser())
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
