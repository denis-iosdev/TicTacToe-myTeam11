//
//  SettingsView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 02/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var storageManager = StorageManager()
    
    var body: some View {
        VStack {
            TimerView(
                isTimerEnabled: $storageManager.settings.isTimerEnabled,
                timerSeconds: $storageManager.settings.timerSeconds
            )
                
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: storageManager.settings.isTimerEnabled)
    }
}

#Preview {
    SettingsView()
}
