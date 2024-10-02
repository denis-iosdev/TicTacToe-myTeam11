//
//  View+Ex.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 02.10.2024.
//

import SwiftUI

extension View {
    func resultButton(color: Color) -> some View {
        modifier(ResultButton(color: color))
    }
}
