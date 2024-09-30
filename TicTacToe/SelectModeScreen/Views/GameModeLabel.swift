//
//  GameModeLabel.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI

struct GameModeLabel: View {
    let title: String
    let iconName: String
    
    var body: some View {
        Label(title, image: iconName)
            .padding()
            .font(.system(size: 20))
            .foregroundStyle(.black)
            .background(Color.buttonBackground)
            .cornerRadius(30)
    }
}

#Preview {
    GameModeLabel(title: "Single Player", iconName: "SinglePlayerButtonIcon")
}
