//
//  Int+Ex.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 02.10.2024.
//

import Foundation

extension Int {
    var timeFormatter: String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}
