//
//  UserImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.06.2024.
//

import SwiftUI

struct UserImage: View {
    var userImage: String = ""
    var size: CGFloat = 150
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.accent, lineWidth: 2)
                .fill(.main)
                .frame(width: size)
            
            if let uiImage = loadImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
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
            .frame(width: size / 1.6)
            .foregroundStyle(.accent)
    }
}

#Preview {
    UserImage(userImage: userImagePlaceholder3)
}
