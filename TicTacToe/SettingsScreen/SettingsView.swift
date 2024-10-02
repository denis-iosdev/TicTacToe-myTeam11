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
            VStack(spacing: 20) {
                HStack {
                    Toggle(isOn: $storageManager.settings.isTimerEnabled) {
                        Text("Game Time")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Color.buttonBackground)
                    .cornerRadius(30)
                    
                }
                
                if storageManager.settings.isTimerEnabled {
                    VStack {
                        Text("Duration")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        HStack() {
                            Text("\(formattedTime(seconds: storageManager.settings.timerSeconds))")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            
                            Stepper("", value: $storageManager.settings.timerSeconds, in: 15...300, step: 15)
                        }
                    }
                    .padding()
                    .background(Color.buttonBackground)
                    .cornerRadius(30)
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.15), radius: 10)
                
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: storageManager.settings.isTimerEnabled)
    }
    
    private func formattedTime(seconds: Int) -> String {
        let minute = seconds / 60
        let seconds = seconds % 60
        return "\(minute) min. \(seconds) sec."
    }
}

#Preview {
    SettingsView()
}
