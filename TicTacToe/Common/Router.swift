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

// window
// --> Onbording (done)
// Onbording
// --> help (wait screen) !!!!!
// --> setting (done)
// --> gameMod (done)

// help
// <-- (back) Onbording (wait screen) !!!!!
// setting
// <-- (back) Onbording (done)

// gameMod
// <-- (back) Onbording (done)
// --> setting (done)
// --> (ture) game (done)
// --> (false) game (done)
// --> difflvl (fullScreen) (под вопросом как будет работать переход назад) (wait screen) !!!!!
// --> leaderboard (wait screen) !!!!!

// setting
// <-- (back) gameMod (done)
// difflvl
// <-- (back) gameMod (wait screen) !!!!!
// leaderboard
// <-- (back) gameMod (wait screen) !!!!!

// game
// <-- (back) gameMod (done)
// --> result (String, GameResult) (done)
