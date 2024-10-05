//
//  DifficultyLevel.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 05.10.2024.
//

import Foundation

enum DifficultyLevel: String {
    case easy, medium, hard
    
    var title: String {
        switch self {
        default:
            self.rawValue.capitalized
        }
    }
}
