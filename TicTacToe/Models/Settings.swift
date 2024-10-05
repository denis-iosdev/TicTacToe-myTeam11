//
//  Settings.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

struct GameSettings {
    var difficultyLevel: DifficultyLevel
    var isMusicEnabled: Bool
    var choosedGenre: MusicGenres
    var isTimerEnabled: Bool
    var timerSeconds: Int
    var xSkin: Int
    var oSkin: Int
    
    init(
        difficultyLevel: DifficultyLevel = .easy,
        isMusicEnabled: Bool = true,
        choosedGenre: MusicGenres = .classic,
        isTimerEnabled: Bool = false,
        timerSeconds: Int = 60,
        xSkin: Int = 1,
        oSkin: Int = 1
    ) {
        self.difficultyLevel = difficultyLevel
        self.isMusicEnabled = isMusicEnabled
        self.choosedGenre = choosedGenre
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
    case classic = "Classic"
    case pixel = "Pixel"
    case jazz = "Jazz"
    
    var songName: String {
        "\(self.rawValue).mp3"
    }
}
