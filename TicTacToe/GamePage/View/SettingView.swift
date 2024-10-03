//
//  SettingView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 03.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: StorageManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Таймер")) {
                    Toggle(isOn: $settings.isTimerEnabled) {
                        Text("Включить таймер")
                    }
                    if settings.isTimerEnabled {
                        Stepper(value: $settings.timerSeconds, in: 10...300, step: 5) {
                            Text("Длительность таймера: \(settings.timerSeconds) секунд")
                        }
                    }
                }
                
                Section(header: Text("Изображения")) {
                    Picker("Изображение крестика", selection: $settings.xSkin) {
                        Text("xSkin1").tag(1)
                        Text("xSkin2").tag(2)
                    }
                    
                    Picker("Изображение нолика", selection: $settings.oSkin) {
                        Text("oSkin1").tag(1)
                        Text("oSkin2").tag(2)
                    }
                }
            }
            .navigationTitle("Настройки")
            .navigationBarItems(trailing: Button("Готово") {
                dismiss()
            })
        }
    }
}

#Preview {
    SettingsView(settings: StorageManager())
}
