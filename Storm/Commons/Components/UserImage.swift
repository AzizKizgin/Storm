//
//  UserImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.06.2024.
//

import SwiftUI

struct UserImage: View {
    var userImage: String = ""
    var size: CGFloat = 175
    var body: some View {
        Circle()
            .stroke(.accent, lineWidth: 2)
            .frame(width: size)
            .background{
                ZStack {
                    Circle().fill(.main)
                    if !userImage.isEmpty, let image = ImageManager.shared.convertStringToImage(for: userImage){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                    else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size / 1.6)
                            .foregroundStyle(.accent)
                    }
                }
            }
    }
}

#Preview {
    UserImage(userImage: userImagePlaceholder3)
}
