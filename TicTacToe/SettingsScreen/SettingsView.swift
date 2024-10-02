//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 02/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var storageManager = StorageManager()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
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
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button() {
                            dismiss()
                        } label: {
                            Image("backButtonIconImage")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
