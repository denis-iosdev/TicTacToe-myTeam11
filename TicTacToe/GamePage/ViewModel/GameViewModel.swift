//
//  GameService.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {
    @Published var player1: Player
    @Published var player2: Player
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset()
    @Published var isThinking = false
    
    var isTwoPlayerMode: Bool
    
    var currentPlayer: Player {
        player1.isCurrent ? player1 : player2
    }
    
    var boardDisabled: Bool {
        gameOver || isThinking
    }
    
    init(isTwoPlayerMode: Bool) {
        self.isTwoPlayerMode = isTwoPlayerMode
        self.player1 = Player(gamePiece: .x, name: isTwoPlayerMode ? "Player One" : "You")
        self.player2 = Player(gamePiece: .o, name: isTwoPlayerMode ? "Player Two" : "Computer")
    }
    
    func reset() {
        player1.isCurrent = true
        player2.isCurrent = false
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Move.all
        gameBoard = GameSquare.reset()
    }
    
    func updateMoves(index: Int) {
        if player1.isCurrent {
            player1.moves.append(index)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index)
            gameBoard[index].player = player2
        }
    }
    
    func checkWinner() {
        if player1.isWinner() || player2.isWinner() {
            gameOver = true
        }
    }
    
    func toggleCurrentPlayer() {
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func makeMove(index: Int) {
        if gameBoard[index].player == nil {
            
            updateMoves(index: index)
            
            checkWinner()
            
            if !gameOver {
                if let matchingIndex = possibleMoves.firstIndex(where: { $0 == index }) {
                    possibleMoves.remove(at: matchingIndex)
                }
                toggleCurrentPlayer()
                
                if !isTwoPlayerMode && currentPlayer == player2 {
                    Task {
                        await makeComputerMove()
                    }
                }
            }
            
            if possibleMoves.isEmpty {
                gameOver = true
            }
        }
    }
    
    func makeComputerMove() async {
        guard !gameOver else { return }
        isThinking.toggle()
        
        // Выбираем случайный доступный ход
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        if let move = possibleMoves.randomElement() {
            if let matchingIndex = Move.all.firstIndex(where: { $0 == move }) {
                withAnimation {
                    makeMove(index: matchingIndex)
                }
            }
        }
        isThinking.toggle()
    }
}
