//
//  GamePiece.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import Foundation

enum GamePiece {
    case x, o
    
    var image: String {
        switch self {
        case .x:
            "Xskin1"
        case .o:
            "Oskin1"
        }
    }
}
