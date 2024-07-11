//
//  DefaultUserImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 25.06.2024.
//

import SwiftUI

struct DefaultUserImage: View {
    var size: CGFloat? = nil
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size != nil ? size! / 1.6 : nil)
            .foregroundStyle(.accent)
            .background(.main)
    }
}

#Preview {
    DefaultUserImage()
}
