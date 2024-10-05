//
//  Player.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import Foundation

enum GamePiece {
    case x
    case o
}

struct Player: Equatable {
    
    let gamePiece: GamePiece
    let name: String
    var moves: [Int] = []
    var isCurrent: Bool = false
}
