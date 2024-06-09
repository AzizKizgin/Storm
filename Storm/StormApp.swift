//
//  StormApp.swift
//  Storm
//
//  Created by Aziz Kızgın on 8.06.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct StormApp: App {
    var body: some Scene {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        WindowGroup {
            ContentView()
        }
    }
}
