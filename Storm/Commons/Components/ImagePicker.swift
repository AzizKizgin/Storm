//
//  ImagePicker.swift
//  Storm
//
//  Created by Aziz Kızgın on 27.06.2024.
//

import SwiftUI
import PhotosUI

struct ImagePicker: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    var isLoading: Binding<Bool>?
    @State private var pickerItem: PhotosPickerItem?
    func body(content: Content) -> some View {
        content
            .photosPicker(isPresented: $isPresented, selection: $pickerItem, matching: .images)
            .onChange(of: pickerItem) { _ , newItem in
                Task {
                    isLoading?.wrappedValue = true
                    if let loadedData = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: loadedData)
                    {
                        image = uiImage
                    }
                    isLoading?.wrappedValue = false
                }
            }
            .onChange(of: image) { _, newValue in
                if newValue == nil {
                    self.pickerItem = nil
                }
            }
    }
}

extension View {
    func imagePicker(isPresented: Binding<Bool>, image: Binding<UIImage?>, isLoading: Binding<Bool>? = nil) -> some View {
        self.modifier(ImagePicker(isPresented: isPresented, image: image, isLoading: isLoading))
    }
}

private struct ImagePickerPreview: View {
    @State private var isPresented: Bool = false
    @State private var image: UIImage?
    @State private var isLoading: Bool = false
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .controlSize(.large)
            }
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        self.image = nil
                    }
            }
            else {
                Button(action: {isPresented.toggle()}, label: {
                    Text("Button")
                })
            }
        }
        .imagePicker(isPresented: $isPresented, image: $image,isLoading: $isLoading)
    }
}

#Preview {
    ImagePickerPreview()
}
