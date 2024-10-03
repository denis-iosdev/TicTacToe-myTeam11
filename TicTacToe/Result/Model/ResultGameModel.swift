//
//  ResultGame.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 03.10.24.
//

import Foundation

struct ResultGameModel: Hashable {
    enum Result {
        case win
        case lose
        case draw
        
        var imageName: String {
            switch self {
            case .win:
                "winIcon"
            case .lose:
                "loseIcon"
            case .draw:
                "drawIcon"
            }
        }
    }
    
    let userName: String
    let result: Result
}
