//
//  DefaultUserImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 25.06.2024.
//

import SwiftUI

struct DefaultUserImage: View {
    let size: CGFloat
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size / 1.6)
            .foregroundStyle(.accent)
    }
}

#Preview {
    DefaultUserImage(size: 400)
}
