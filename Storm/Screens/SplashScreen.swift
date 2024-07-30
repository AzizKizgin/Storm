//
//  SplashScreen.swift
//  Storm
//
//  Created by Aziz Kızgın on 30.07.2024.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            StartImage()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.main)
    }
}

#Preview {
    SplashScreen()
}
