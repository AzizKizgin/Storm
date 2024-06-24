//
//  ExpandedUserImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ExpandedUserImage: View {
    var userImage: String = ""
    var body: some View {
        VStack {
            if let uiImage = loadImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 400)
                    .clipShape(Rectangle())
            } else {
                defaultImage
            }
        }
    }
    
    private func loadImage() -> UIImage? {
        guard !userImage.isEmpty else { return nil }
        return ImageManager.shared.convertStringToImage(for: userImage)
    }
    
    private var defaultImage: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 400 / 1.6)
            .foregroundStyle(.accent)
    }
}

#Preview {
    ExpandedUserImage(userImage: userImagePlaceholder3)
}
