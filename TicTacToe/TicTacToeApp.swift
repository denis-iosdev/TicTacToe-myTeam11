//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Денис Гиндулин on 29.09.2024.
//

import SwiftUI
import NavigationBackport

@main
struct TicTacToeApp: App {
    
    @State var path = NBNavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NBNavigationStack(path: $path) {
                OnboardingView()
            }
            .onAppear {
                changeNavBarBackgroundColor()
            }
        }
    }
    
    private func changeNavBarBackgroundColor() {
        UINavigationBar.appearance().barTintColor = .white
    }
}
