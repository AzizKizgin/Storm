//
//  StartView.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack{
            Spacer()
            TopMessage(title: "Get Started", message: "Start with Sign Up or Sign In.")
            Spacer()
            StartImage()
            Spacer()
            VStack(spacing: 16) {
                FormButton("Sign up", onPress: {})
                FormButton("Sign in", onPress: {}, light: true)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.main)
    }
}

#Preview {
    StartView()
}
