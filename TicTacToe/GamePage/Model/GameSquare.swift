//
//  GameSquare.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import Foundation

struct GameSquare {
    var index: Int
    var player: Player?
    
    func image(gameSettings: StorageManager) -> String? {
        guard let player = player else { return nil }
        return player.gamePiece == .x ? "Xskin\(gameSettings.xSkin)" : "Oskin\(gameSettings.oSkin)"
    }
    
    static func defaultValue() -> [GameSquare] {
        var squares: [GameSquare] = []
        for i in 0..<9 {
            squares.append(GameSquare(index: i))
        }
        return squares
    }
}
