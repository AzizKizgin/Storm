//
//  ContactModalItem.swift
//  Storm
//
//  Created by Aziz Kızgın on 11.07.2024.
//

import SwiftUI

struct ContactModalItem: View {
    let contact: UserResponse
    var body: some View {
        VStack(spacing: 0) {
            ExpandedUserImage(userImage: contact.profilePicture ?? "", size: 270)
                .overlay(alignment: .top){
                    Color.accent
                        .opacity(0.3)
                        .frame(height: 50)
                        .overlay {
                            Text(contact.username)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .bold()
                        }
                }
            HStack(spacing: 0) {
                Button(action: {}, label: {
                    Image(systemName: "text.bubble")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                })
                .padding(.vertical, 10)
                
                Button(action: {}, label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                })
                .padding(.vertical, 10)
            }
      
        }
        .background(.main)
        .frame(width: 270)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(.rect)
    }
}

#Preview {
    ContactModalItem(contact: dummyUserResponse)
}
