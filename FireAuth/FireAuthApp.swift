//
//  FireAuthApp.swift
//  FireAuth
//
//  Created by Koulu on 25.3.2022.
//

import SwiftUI
import Firebase // Firebase auth

@main
struct FireAuthApp: App {
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // Firebase auth
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()  // Firebase auth
            ContentView()
                .environmentObject(viewModel)   // Firebase auth
        }
    }
}

// Firebase auth
/* class AppDelegate: NSObject, UIApplicationDelegate {
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
 FirebaseApp.configure()
 return true
 }
 } */
