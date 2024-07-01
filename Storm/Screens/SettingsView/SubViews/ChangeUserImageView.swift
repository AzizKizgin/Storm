//
//  ChangeUserImageView.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.06.2024.
//

import SwiftUI

struct ChangeUserImageView: View {
    @Environment(\.dismiss) private var dismiss
    var userImage: String = ""
    let onChange: (String) -> Void
    @State private var showPicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isLoading: Bool = false
    @State private var showError: Bool = false
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
                            if let image = selectedImage, let imageString = ImageManager.shared.convertImageToString(for: image) {
                                onChange(imageString)
                                dismiss()
                            }
                            else {
                                showError.toggle()
                            }
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
        .alert("An error occured while proccess", isPresented: $showError){
            Button("Okay", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        ChangeUserImageView(userImage: userImagePlaceholder3, onChange: {_ in })
    }
}
