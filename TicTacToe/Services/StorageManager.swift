//
//  StorageManager.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

final class StorageManager: ObservableObject {
    @AppStorage("isTimerEnabled") var isTimerEnabled = false
    @AppStorage("timerSeconds") var timerSeconds = 60
    @AppStorage("xSkin") var xSkin = 1
    @AppStorage("oSkin") var oSkin = 1
    
    var settings: GameSettings {
        get {
            GameSettings(
                isTimerEnabled: isTimerEnabled,
                timerSeconds: timerSeconds,
                xSkin: xSkin,
                oSkin: oSkin
            )
        } set {
            isTimerEnabled = newValue.isTimerEnabled
            timerSeconds = newValue.timerSeconds
            xSkin = newValue.xSkin
            oSkin = newValue.oSkin
        }
    }
}
