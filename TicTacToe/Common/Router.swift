//
//  Router.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 03.10.24.
//

import Foundation

enum Router: Hashable {
    case onbording
    case help
    case setting
    case gameMod
    case game(Bool)
    case leaderboard
    case result(ResultGameModel)
}

struct ResultGame: Hashable {
    let name: String
    let image: String
}

// window
// --> Onbording
// Onbording
// --> help
// --> setting
// --> gameMod

// help
// <-- (back) Onbording
// setting
// <-- (back) Onbording

// gameMod
// <-- (back) Onbording
// --> setting
// --> (ture) game
// --> (false) game
// --> difflvl (fullScreen) (под вопросом как будет работать переход назад)
// --> leaderboard

// setting
// <-- (back) gameMod
// difflvl
// <-- (back) gameMod
// leaderboard
// <-- (back) gameMod

// game
// <-- (back) gameMod
// --> result (String, GameResult)
