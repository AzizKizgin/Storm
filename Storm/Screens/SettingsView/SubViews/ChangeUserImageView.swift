//
//  ChangeUserImageView.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ChangeUserImageView: View {
    var userImage: String = ""
    var body: some View {
        ExpandedUserImage(userImage: userImage)
            .navigationTitle("Profile Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.accent)
                        .font(.title2)
                }
            }
    }
}

#Preview {
    NavigationStack {
        ChangeUserImageView(userImage: userImagePlaceholder3)
    }
}
