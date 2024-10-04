//
//  StorageManager.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

final class StorageManager: ObservableObject {
    @AppStorage("difficultyLevel") var difficultyLevelRawValue: String = DifficultyLevel.easy.rawValue
    @AppStorage("isTimerEnabled") var isTimerEnabled = false
    @AppStorage("timerSeconds") var timerSeconds = 60
    @AppStorage("xSkin") var xSkin = 1
    @AppStorage("oSkin") var oSkin = 1
    
    private var difficultyLevel: DifficultyLevel {
        get {
            DifficultyLevel(rawValue: difficultyLevelRawValue) ?? .easy
        } set {
            difficultyLevelRawValue = newValue.rawValue
        }
    }
    
    var settings: GameSettings {
        get {
            GameSettings(
                difficultyLevel: difficultyLevel,
                isTimerEnabled: isTimerEnabled,
                timerSeconds: timerSeconds,
                xSkin: xSkin,
                oSkin: oSkin
            )
        } set {
            difficultyLevel = newValue.difficultyLevel
            isTimerEnabled = newValue.isTimerEnabled
            timerSeconds = newValue.timerSeconds
            xSkin = newValue.xSkin
            oSkin = newValue.oSkin
        }
    }
}
