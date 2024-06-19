//
//  TopMessage.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct TopMessage: View {
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    var body: some View {
        VStack{
            Text(title)
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Text(message)
                .font(.callout)
        }
        .foregroundStyle(.accent)
    }
}

#Preview {
    TopMessage(title: "Get Started", message: "Start with Sign Up or Sign In.")
}
