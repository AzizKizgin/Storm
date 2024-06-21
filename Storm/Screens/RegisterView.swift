//
//  RegisterView.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

@MainActor
struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable private var registerVM = RegisterViewModel()
    var body: some View {
        VStack {
            TopMessage(title: "Register", message: "Sign up and start connecting!")
            Spacer()
            VStack(spacing: 75) {
                VStack(spacing: 32){
                    FormInput("username", text: $registerVM.registerInfo.username)
                    FormInput("email", text: $registerVM.registerInfo.email, type: .email)
                    FormInput("password", text: $registerVM.registerInfo.password, type: .password)
                    FormInput("confirm password", text: $registerVM.registerInfo.confirmPassword, type: .password)
                    CheckBox(isChecked: $registerVM.isChecked, title: "I agree with terms and conditions")
                        .underline()
                }
                .padding(.horizontal)
                FormButton("Sign up", onPress: registerVM.register, isLoading: registerVM.isLoading)
            }
            .alert(registerVM.errorMessage, isPresented: $registerVM.showError){
                Button("Okay", role: .cancel) {}
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.main)
        .onChange(of: registerVM.isSuccess) { _ , _ in
            if registerVM.isSuccess {
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}
