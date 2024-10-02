//
//  StorageManager.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

final class StorageManager: ObservableObject {
    @AppStorage("isTimerEnabled") private var isTimerEnabled = false
    @AppStorage("timerSeconds") private var timerSeconds = 60
    @AppStorage("xSkin") private var xSkin = 1
    @AppStorage("oSkin") private var oSkin = 1
    
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
    
    func updateTimer(isEnabled: Bool, seconds: Int?) {
        isTimerEnabled = isEnabled
        timerSeconds = seconds ?? 60
    }
    
    func updateSkins(newXSkin: Int, newOSkin: Int) {
        xSkin = newXSkin
        oSkin = newOSkin
    }
}
