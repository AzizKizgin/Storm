//
//  Modal.swift
//  Storm
//
//  Created by Aziz Kızgın on 10.07.2024.
//

import SwiftUI

struct ModalViewModifier<ModalContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let onClose: () -> Void
    let modalContent: ModalContent

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if isPresented {
                Color.accent
                    .opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        onClose()
                    }
                    .overlay{
                        GeometryReader { reader in
                            modalContent
                                .position(x: reader.size.width / 2, y: reader.size.height / 4)
                        }
                    }
            }
        }
    }
}

extension View {
    func modal<ModalContent: View>(
        isPresented: Binding<Bool>,
        onClose: @escaping () -> Void,
        @ViewBuilder modalContent: () -> ModalContent
    ) -> some View {
        self.modifier(ModalViewModifier(isPresented: isPresented, onClose: onClose, modalContent: modalContent()))
    }
}

#Preview {
    ContactsView()
}
