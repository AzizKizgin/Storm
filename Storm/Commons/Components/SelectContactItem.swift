//
//  AddMessageContact.swift
//  Storm
//
//  Created by Aziz Kızgın on 24.07.2024.
//

import SwiftUI

struct SelectContactItem: View {
    @State private var showModal: Bool = false
    let user: UserResponse
    var onPress: () -> Void = {}
    var body: some View {
        HStack(spacing: 0){
            UserImage(userImage: user.profilePicture ?? "", size: 50)
                .padding(.trailing)
                .onTapGesture {
                    UIView.setAnimationsEnabled(false)
                    showModal.toggle()
                }
            VStack {
                Text( user.username)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.primary)
                  
                Text(user.about)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
            }
            .lineLimit(1)
        }
        .contentShape(.rect)
        .onTapGesture {
            onPress()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(.main)
        .fullScreenCover(isPresented: $showModal) {
            ZStack {
                Color.accent
                    .opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showModal.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            UIView.setAnimationsEnabled(true)
                        }
                    }
                ContactModalItem(contact: user)
            }
            .presentationBackground(.clear)
        }
    }
}

extension SelectContactItem {
    func onPress(_ onPress: @escaping () -> Void) -> SelectContactItem {
        var copy = self
        copy.onPress = onPress
        return copy
    }
}


#Preview {
    SelectContactItem(user: dummyUserResponse2)
}
