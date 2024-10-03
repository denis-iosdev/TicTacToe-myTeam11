//
//  Settings.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

struct GameSettings {
    var isTimerEnabled: Bool
    var timerSeconds: Int
    var xSkin: Int
    var oSkin: Int
    
    init(isTimerEnabled: Bool = false, timerSeconds: Int = 60, xSkin: Int = 1, oSkin: Int = 1) {
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
