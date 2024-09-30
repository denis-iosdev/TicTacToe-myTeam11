//
//  PlayerIcon.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI

struct PlayerIconView: View {
    let text: String
    let isTimerOn: Bool
    
    var body: some View {
        VStack {
            Image(.xskin1)
                .padding(.horizontal, 24)
            Text(text)
                .font(.system(size: 16, weight: .semibold))
        }
        
        .padding(.vertical, 10)
        .background(isTimerOn ? .lightBlue : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
