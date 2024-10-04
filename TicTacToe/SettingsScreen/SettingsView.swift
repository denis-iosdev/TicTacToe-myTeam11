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
                    TimerView(
                        isTimerEnabled: $storageManager.settings.isTimerEnabled,
                        timerSeconds: $storageManager.settings.timerSeconds
                    )
                    
                    SkinSelectionView(
                        selectedXSkin: $storageManager.settings.xSkin,
                        selectedOSkin: $storageManager.settings.oSkin
                    )
                }
                .padding()
                .animation(.easeInOut(duration: 0.3), value: storageManager.settings.isTimerEnabled)
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
