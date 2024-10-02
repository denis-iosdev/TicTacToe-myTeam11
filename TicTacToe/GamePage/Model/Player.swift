//
//  Player.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import Foundation

struct Player: Equatable {
    
    enum GamePiece: String {
        case x = "Xskin1"
        case o = "Oskin1"
    }
    
    let gamePiece: GamePiece
    let name: String
    var moves: [Int] = []
    var isCurrent: Bool = false
}
