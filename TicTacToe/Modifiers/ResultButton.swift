//
//  ResultButton.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 02.10.2024.
//

import SwiftUI

struct ResultButton: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .foregroundStyle(color)
    }
}
