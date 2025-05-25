//
//  wishuApp.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

import SwiftUI
import FirebaseCore

@main
struct wishuApp: App {
    
    init() {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.debug)
    }
    
    @State private var showOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if showOnboarding {
                    OnBoardingView {
                        showOnboarding = false
                    }
                } else {
                    ChatView()
                }
            }
        }
    }
}
