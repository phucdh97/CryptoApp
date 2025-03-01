//
//  CryptoSwiftUIApp.swift
//  CryptoSwiftUI
//
//  Created by Phuc Huu Do on 21/2/25.
//

import SwiftUI

@main
struct CryptoSwiftUIApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
