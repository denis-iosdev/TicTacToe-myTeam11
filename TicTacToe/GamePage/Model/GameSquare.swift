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
    
    var image: String? {
        player?.gamePiece.rawValue
    }
    
    static func reset() -> [GameSquare] {
        var squares: [GameSquare] = []
        for i in 0..<9 {
            squares.append(GameSquare(index: i))
        }
        return squares
    }
}
