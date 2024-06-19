//
//  StartImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI

struct StartImage: View {
    var body: some View {
        Image("start")
            .resizable()
            .scaledToFit()
            .frame(width: 250)
            .foregroundStyle(.accent)
    }
}

#Preview {
    StartImage()
}
