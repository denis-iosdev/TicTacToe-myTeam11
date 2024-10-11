//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 02/10/2024.
//

import SwiftUI
import NavigationBackport

struct SettingsView: View {
    @EnvironmentObject var navigator: PathNavigator
    @ObservedObject var storageManager: StorageManager
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 20) {
                        TimerView(
                            isTimerEnabled: $storageManager.settings.isTimerEnabled,
                            timerSeconds: $storageManager.settings.timerSeconds
                        )
                        
                        MusicView(
                            isMusicEnabled: $storageManager.isMusicEnabled,
                            choosedGenre: $storageManager.settings.choosedGenre
                        )
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.15), radius: 10)
                    
                    SkinSelectionView(
                        selectedXSkin: $storageManager.settings.xSkin,
                        selectedOSkin: $storageManager.settings.oSkin
                    )
                    
                    Button("Developers".localized) {
                        navigator.push(Router.aboutUs)
                    }
                    .foregroundStyle(.gray)
                }
                .padding()
                .animation(.easeInOut(duration: 0.3), value: storageManager.settings.isTimerEnabled)
                .animation(.easeInOut(duration: 0.3), value: storageManager.settings.isMusicEnabled)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolBarNavigationItems(
                        leftAction: { navigator.pop() }
                    )
                    
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        SettingsView(storageManager: StorageManager())
    }
}
