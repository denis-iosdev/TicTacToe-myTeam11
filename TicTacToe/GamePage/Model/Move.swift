//
//  Move.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import Foundation

enum Move {
    static let all = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    static let winningMoves: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // Горизонтали
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // Вертикали
        [0, 4, 8], [2, 4, 6]             // Диагонали
    ]
}
