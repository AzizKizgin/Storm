//
//  StartView.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct StartView: View {
    @State private var showSignIn: Bool = false
    @State private var showSignUp: Bool = false
    var body: some View {
        VStack{
            Spacer()
            TopMessage(title: "Get Started", message: "Start with Sign Up or Sign In.")
            Spacer()
            StartImage()
            Spacer()
            VStack(spacing: 16) {
                FormButton("Sign up", onPress: {showSignUp.toggle()})
                FormButton("Sign in", onPress: {showSignIn.toggle()}, light: true)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.main)
        .navigationDestination(isPresented: $showSignUp){RegisterView()}
        .navigationDestination(isPresented: $showSignIn){LoginView()}
    }
}

#Preview {
    NavigationStack {
        StartView()
    }
}
