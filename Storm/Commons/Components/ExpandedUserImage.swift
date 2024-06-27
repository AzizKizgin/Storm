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
            if let uiImage = ImageManager.shared.convertStringToImage(for: userImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Rectangle())
            } else {
                DefaultUserImage(size: 400)
            }
        }
    }
}

#Preview {
    ExpandedUserImage(userImage: userImagePlaceholder3)
}
