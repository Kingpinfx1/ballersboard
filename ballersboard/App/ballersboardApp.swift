//
//  ballersboardApp.swift
//  ballersboard
//
//  Created by kingpin on 6/13/25.
//

import SwiftUI
import Firebase

@main
struct ballersboardApp: App {
    
    @StateObject  var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                OnboardingView()
                    .environmentObject(viewModel)
            }
        }
    }
}


