//
//  ChangeUserImageView.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ChangeUserImageView: View {
    var userImage: String = ""
    @State private var showPicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isLoading: Bool = false
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .controlSize(.large)
            }
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            }
            else {
                ExpandedUserImage(userImage: userImage)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.main)
        .imagePicker(isPresented: $showPicker, image: $selectedImage, isLoading: $isLoading)
        .navigationTitle("Profile Image")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                if selectedImage != nil {
                    Image(systemName: "multiply.square")
                        .foregroundStyle(.accent)
                        .font(.title2)
                        .onTapGesture {
                            self.selectedImage = nil
                        }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                if selectedImage != nil {
                    Image(systemName: "checkmark.square")
                        .foregroundStyle(.accent)
                        .font(.title2)
                        .onTapGesture {
                            // save function
                        }
                }
                else {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.accent)
                        .font(.title2)
                        .onTapGesture {
                            showPicker.toggle()
                        }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChangeUserImageView(userImage: userImagePlaceholder3)
    }
}
