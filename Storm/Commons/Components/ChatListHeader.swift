//
//  ChatListHeader.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import SwiftUI

struct ChatListHeader: View {
    @Binding var selectedChats: [String]
    @State private var showSearch: Bool = false
    @State private var text: String = ""
    var body: some View {
        VStack {
            if !selectedChats.isEmpty {
                HStack {
                    Image(systemName: "arrow.backward")
                        .font(.title2)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedChats.removeAll()
                            }
                        }
                    Spacer()
                    HStack(spacing: 25) {
                        Image(systemName: "bell.slash.fill")
                        Image(systemName: "pin.fill")
                        Image("archive")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 29)
                    }
                    .font(.title2)
                }
                .padding(.top)
                .foregroundStyle(.accent)
            }
            else if showSearch {
                HStack {
                    Image(systemName: "arrow.backward")
                        .font(.title2)
                        .foregroundStyle(.accent)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showSearch.toggle()
                            }
                        }
                    TextField("Search...", text: $text)
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.lightMain)
                }
                .transition(.move(edge: .trailing))
            }
            else {
                HStack {
                    Text("Storm")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button {
                        withAnimation(.easeInOut) {
                            showSearch.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                }
                .foregroundStyle(.accent)
            }
        }
        .padding(.bottom)
        .padding(.horizontal)
        .background(.main)
    }
}

#Preview {
    @State var chats: [String] = ["1","2"]
    return ChatListHeader(selectedChats: $chats)
}
