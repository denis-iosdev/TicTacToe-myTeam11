//
//  Player.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import Foundation

struct Player: Equatable {
    let gamePiece: GamePiece
    let name: String
    var moves: [Int] = []
    var isCurrent: Bool = false
    
    func isWinner() -> Bool {
        for moves in Move.winningMoves {
            if moves.allSatisfy(self.moves.contains) {
                return true
            }
        }
        return false
    }
}
