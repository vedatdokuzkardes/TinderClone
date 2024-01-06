//
//  TinderCloneApp.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 13.12.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth


@main
struct TinderCloneApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }

    }
}
