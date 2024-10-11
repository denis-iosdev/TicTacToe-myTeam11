//
//  PlayerIcon.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI

struct PlayerIconView: View {
    let text: String
    let image: String
    
    var body: some View {
        VStack {
            Image(image)
                .padding(.horizontal, 24)
                .frame(height: 53)
            Text(text)
                .font(.system(size: 15, weight: .semibold))
                .minimumScaleFactor(0.5)
        }
        .padding(.vertical, 10)
        .background(.lightBlue)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
