//
//  GameModeLabel.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI

struct MenuButtonsLabel: View {
    let title: String
    let iconName: String
    let colorButton: Color
    
    var body: some View {
        Label(title, image: iconName)
            .frame(maxWidth: .infinity)
            .frame(height: 29)
            .padding(.vertical, 20)
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(.black)
            .background(colorButton)
            .cornerRadius(30)
    }
}

#Preview {
    MenuButtonsLabel(
        title: "Single Player",
        iconName: "SinglePlayerButtonIcon",
        colorButton: Color.buttonLightBackground
    )
}
