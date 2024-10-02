//
//  Settings.swift
//  TicTacToe
//
//  Created by Иван Семикин on 01/10/2024.
//

import SwiftUI

struct GameSettings {
    let isTimerEnabled: Bool
    let timerSeconds: Int
    let xSkin: Int
    let oSkin: Int
    
    var xSkinImageName: String {
        "xSkin\(xSkin)"
    }
    
    var oSkinImageName: String {
        "oSkin\(oSkin)"
    }
}
