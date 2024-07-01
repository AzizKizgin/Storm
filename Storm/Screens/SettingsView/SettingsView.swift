//
//  SettingsView.swift
//  Storm
//
//  Created by Aziz Kızgın on 21.06.2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Bindable private var settingsVM = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let user = users.first {
                NavigationLink {
                    ChangeUserImageView(userImage: userImagePlaceholder3)
                } label: {
                    UserImage(userImage: userImagePlaceholder3)
                        .padding()
                }
                SettingsItem(label: user.username, type: .username, onChange: self.changeUsername)
                SettingsItem(label: user.about, type: .about, onChange: self.changeAbout)
                ThemePicker()
                Spacer()
                Button(action: self.settingsVM.onLogoutPressed, label: {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5) 
                })
                .buttonStyle(BorderedProminentButtonStyle())
            }
        }
        .padding()
        .background(.main)
        .alert(settingsVM.errorMessage, isPresented: $settingsVM.showError){
            Button("Okay", role: .cancel) {}
        }
        .alert(settingsVM.successMessage, isPresented: $settingsVM.isSuccess){
            Button("Okay", role: .cancel) {}
        }
        .alert("Are you sure you want to logout?", isPresented: $settingsVM.showLogoutAlert){
            Button("Yes", role: .destructive) {
                self.logout()
            }
            Button("No", role: .cancel) {}
        }
    }
}

extension SettingsView {
    private func changeUsername(_ username: String) {
        settingsVM.changeUsername(username: username) { isSuccess in
            if isSuccess, let user = users.first {
                user.username = username
            }
        }
    }
    
    private func changeAbout(_ about: String) {
        settingsVM.changeAbout(about: about) { isSuccess in
            if isSuccess, let user = users.first {
                user.about = about
            }
        }
    }
    
    private func logout() {
        settingsVM.logout() { isSuccess in
            if isSuccess {
                try! modelContext.delete(model: User.self)
            }
        }
    }
}


#Preview {
    MainActor.assumeIsolated {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: User.self, configurations: config)
        container.mainContext.insert(dummyUser)
        
        return NavigationStack {
            SettingsView()
                .modelContainer(container)
        }
    }
}
