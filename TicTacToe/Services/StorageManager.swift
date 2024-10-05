//
//  StorageManager.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

final class StorageManager: ObservableObject {
    @AppStorage("isMusicEnabled") var isMusicEnabled = true
    @AppStorage("choosedGenre") var choosedGenreRawValue: String = MusicGenres.classic.rawValue
    @AppStorage("isTimerEnabled") var isTimerEnabled = false
    @AppStorage("timerSeconds") var timerSeconds = 60
    @AppStorage("xSkin") var xSkin = 1
    @AppStorage("oSkin") var oSkin = 1
    
    private var choosedGenre: MusicGenres {
        get {
            MusicGenres(rawValue: choosedGenreRawValue) ?? .classic
        } set {
            choosedGenreRawValue = newValue.rawValue
        }
    }
    
    var settings: GameSettings {
        get {
            GameSettings(
                isMusicEnabled: isMusicEnabled,
                choosedGenre: choosedGenre,
                isTimerEnabled: isTimerEnabled,
                timerSeconds: timerSeconds,
                xSkin: xSkin,
                oSkin: oSkin
            )
        } set {
            isMusicEnabled = newValue.isMusicEnabled
            choosedGenre = newValue.choosedGenre
            isTimerEnabled = newValue.isTimerEnabled
            timerSeconds = newValue.timerSeconds
            xSkin = newValue.xSkin
            oSkin = newValue.oSkin
        }
    }
}
