//
//  ExpandedUserImage.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ExpandedUserImage: View {
    var userImage: String = ""
    var size: CGFloat? = nil
    var body: some View {
        VStack {
            if let uiImage = ImageManager.shared.convertStringToImage(for: userImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: size != nil ? .fill : .fit)
                    .frame(width: size)
                    .frame(height: size)
                    .clipShape(Rectangle())
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: size)
                    .frame(height: size)
                    .aspectRatio(contentMode: size != nil ? .fill : .fit)
                    .clipShape(Rectangle())
                    .foregroundStyle(.accent)
                   
            }
        }
        .background(.main)
    }
}

#Preview {
    ExpandedUserImage(userImage: userImagePlaceholder3,size: 250)
}
