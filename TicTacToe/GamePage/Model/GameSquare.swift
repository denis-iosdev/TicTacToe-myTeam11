//
//  GameSquare.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI

struct GameSquare {
    var id: Int
    var player: Player?
    
    var image: Image {
        return Image(player?.gamePiece.image ?? "")
    }
    
    static func reset() -> [GameSquare] {
        var squares: [GameSquare] = []
        for i in 0..<9 {
            squares.append(GameSquare(id: i))
        }
        return squares
    }
}
