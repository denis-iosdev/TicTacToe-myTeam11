//
//  DifficultyButton.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 04.10.2024.
//

import SwiftUI

struct DifficultyButton: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        Text(text)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(.appBlack)
            .background(RoundedRectangle(cornerRadius: 30).fill(isSelected ? .appPurple : .lightBlue))
    }
}
