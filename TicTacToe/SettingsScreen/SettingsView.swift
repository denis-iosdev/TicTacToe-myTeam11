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
            HStack {
                Toggle(isOn: $storageManager.settings.isTimerEnabled) {
                    Text("Game Time")
                        .font(.system(size: 20))
                }
                .padding()
                .background(Color.buttonBackground)
                .cornerRadius(30)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
