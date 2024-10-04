//
//  Settings.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

struct GameSettings {
    var isMusicEnabled: Bool
    var musicGenres: MusicGenres
    var isTimerEnabled: Bool
    var timerSeconds: Int
    var xSkin: Int
    var oSkin: Int
    
    init(
        isMusicEnabled: Bool = true,
        musicGenres: MusicGenres = .classical,
        isTimerEnabled: Bool = false,
        timerSeconds: Int = 60,
        xSkin: Int = 1,
        oSkin: Int = 1
    ) {
        self.musicGenres = musicGenres
        self.isMusicEnabled = isMusicEnabled
        self.isTimerEnabled = isTimerEnabled
        self.timerSeconds = timerSeconds
        self.xSkin = xSkin
        self.oSkin = oSkin
    }
    
    var xSkinImageName: String {
        "xSkin\(xSkin)"
    }
    
    var oSkinImageName: String {
        "oSkin\(oSkin)"
    }
}

enum MusicGenres: String, CaseIterable {
    case classical = "Classical"
    case instrumentals = "Instrumentals"
    case nature = "Nature"
}
