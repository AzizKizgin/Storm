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
            
            if let uiImage = ImageManager.shared.convertStringToImage(for: userImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                DefaultUserImage(size: size)
            }
        }
    }
}

#Preview {
    UserImage(userImage: userImagePlaceholder3)
}
