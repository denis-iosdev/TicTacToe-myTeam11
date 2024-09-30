//
//  PlayingFieldView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI

struct PlayingFieldView: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    let viewModel: GameViewModel
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<9) { index in
                Button {
                    viewModel.makeMove(index: index)
                } label: {
                    viewModel.gameBoard[index].image
                        .resizable()
                        .padding(10)
                }
                .background(.lightBlue)
                .frame(height: getWidth())
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .disabled(viewModel.boardDisabled)
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.2), radius: 10)
    }
    
    func getWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - ((44 * 2) + (20 * 4))
        return width / 3
    }
}
