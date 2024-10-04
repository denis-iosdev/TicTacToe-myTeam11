//
//  PlayingFieldView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI

struct PlayingFieldView: View {
    @ObservedObject var settings: StorageManager
    
    let viewModel: GameViewModel
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    
    // Массив выигрышных комбинаций и кортеж координат для отрисовки линии
    private let winningLines: [[Int]: (start: CGPoint, end: CGPoint)] = [
        // Горизонтальные линии
        [0, 1, 2]: (start: CGPoint(x: 0.1, y: 0.2), end: CGPoint(x: 0.9, y: 0.2)),
        [3, 4, 5]: (start: CGPoint(x: 0.1, y: 0.5), end: CGPoint(x: 0.9, y: 0.5)),
        [6, 7, 8]: (start: CGPoint(x: 0.1, y: 0.8), end: CGPoint(x: 0.9, y: 0.8)),
        
        // Вертикальные линии
        [0, 3, 6]: (start: CGPoint(x: 0.19, y: 0.1), end: CGPoint(x: 0.19, y: 0.9)),
        [1, 4, 7]: (start: CGPoint(x: 0.5, y: 0.1), end: CGPoint(x: 0.5, y: 0.9)),
        [2, 5, 8]: (start: CGPoint(x: 0.81, y: 0.1), end: CGPoint(x: 0.81, y: 0.9)),
        
        // Диагональные линии
        [0, 4, 8]: (start: CGPoint(x: 0.1, y: 0.1), end: CGPoint(x: 0.9, y: 0.9)),
        [2, 4, 6]: (start: CGPoint(x: 0.9, y: 0.1), end: CGPoint(x: 0.1, y: 0.9)),
    ]
    
    var body: some View {
            ZStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<9) { index in
                        Button {
                            viewModel.makeMove(index: index)
                        } label: {
                            if let imageName = viewModel.gameBoard[index].image(gameSettings: settings) {
                                Image(imageName)
                                    .resizable()
                                    .padding(10)
                            } else {
                                Color.lightBlue
                            }
                        }
                        .background(.lightBlue)
                        .frame(height: getSquareWidth())
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .disabled(viewModel.boardDisabled)
                .padding(20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.2), radius: 10)
                
                // Создание перечеркивающей линии
                if let winningCombination = viewModel.winningCombination {
                    if let linePoints = winningLines[winningCombination] {
                        WinningLineView(line: linePoints)
                    }
                }
            }
            .frame(width: getFieldWidth(), height: getFieldWidth())
    }
    
    // Получение ширины игрового поля
    func getFieldWidth() -> CGFloat {
        return UIScreen.main.bounds.width - (44 * 2)
    }
    
    // Получение ширины одной ячейки игрового поля
    func getSquareWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - ((44 * 2) + (20 * 4))
        return width / 3
    }
}
