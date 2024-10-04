//
//  GameService.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI
import NavigationBackport

enum DifficultyLevel {
    case easy, medium, hard
    
//    static var selectedLevel: DifficultyLevel = .easy
}

@MainActor
final class GameViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var player1: Player
    @Published var player2: Player
    @Published var winner: Player?
    
    @Published var possibleMoves = Move.all
    @Published var winningCombination: [Int]? = nil
    
    @Published var gameOver = false
    @Published var isThinking = false
    
    @Published var gameBoard = GameSquare.defaultValue()
    
    @Published var timerRunning = false
    @Published var timeRemaining = 0
    
    @Published var resultModel: ResultGameModel?
    
    // MARK: - Properties
    let settings: StorageManager
    
    var isTwoPlayerMode: Bool
    var difficultyLevel: DifficultyLevel?
    
    var currentPlayer: Player {
        player1.isCurrent ? player1 : player2
    }
    
    var boardDisabled: Bool {
        gameOver || isThinking || timeRemaining == 0
    }
    
    // MARK: - Initializer
    init(isTwoPlayerMode: Bool, difficultyLevel: DifficultyLevel?, settings: StorageManager) {
        self.isTwoPlayerMode = isTwoPlayerMode
        self.difficultyLevel = difficultyLevel
        self.settings = settings
        self.player1 = Player(gamePiece: .x, name: isTwoPlayerMode ? "Player One" : "You")
        self.player2 = Player(gamePiece: .o, name: isTwoPlayerMode ? "Player Two" : "Computer")
        
        settings.isTimerEnabled ? startTimer() : nil
    }
    
    // MARK: - Methods
    func timerTick() {
        guard timerRunning, timeRemaining > 0 else {
            if settings.isTimerEnabled {
                gameOver = true
            }
            timerRunning = false
            return
        }
        
        timeRemaining -= 1
    }
    
    func handleGameOver() {
        if gameOver {
            self.openResultView()
        }
    }
    
    func reset() {
        gameOver = false
        player1.isCurrent = true
        player2.isCurrent = false
        
        player1.moves.removeAll()
        player2.moves.removeAll()
        
        winningCombination = nil
        resultModel = nil
        winner = nil
        
        possibleMoves = Move.all
        gameBoard = GameSquare.defaultValue()
        
        timeRemaining = settings.timerSeconds
        timerRunning = settings.isTimerEnabled
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
    
    // MARK: - Private Methods
    private func updateMoves(index: Int) {
        if player1.isCurrent {
            player1.moves.append(index)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index)
            gameBoard[index].player = player2
        }
    }
    
    private func checkWinner() {
        let winningCombinations = Move.winningMoves
        
        for combination in winningCombinations {
            if combination.allSatisfy(player1.moves.contains) {
                gameOver = true
                winningCombination = combination
                winner = player1
                return
            } else if combination.allSatisfy(player2.moves.contains) {
                gameOver = true
                winningCombination = combination
                winner = player2
                return
            }
        }
        
        if possibleMoves.isEmpty {
            gameOver = true
        }
    }
    
    private func toggleCurrentPlayer() {
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    private func startTimer() {
        timerRunning = true
        timeRemaining = settings.timerSeconds
    }
    
    private func createResultView(text: String, result: ResultGameModel.Result) {
        let model = ResultGameModel(userName: text, result: result)
        resultModel = model
    }
    
    private func openResultView() {
        if possibleMoves.isEmpty || (settings.isTimerEnabled && timeRemaining == 0) {
            createResultView(text: "Draw!", result: .draw)
        } else if isTwoPlayerMode {
            createResultView(text: "\(winner?.name ?? "") win!", result: .win)
        } else {
            if winner == player1 {
                createResultView(text: "\(player1.name) win!", result: .win)
            } else {
                createResultView(text: "\(player1.name) Lose!", result: .lose)
            }
        }
    }
    
    // MARK: - Computer Moves
    private func makeComputerMove() async {
        guard !gameOver else { return }
        isThinking.toggle()
        
        // Задержка для имитации "мышления" компьютера
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let moveIndex: Int
        
        switch difficultyLevel {
        case .easy:
            moveIndex = selectEasyMove()
        case .medium:
            moveIndex = selectMediumMove()
        case .hard:
            moveIndex = selectHardMove()
        case .none:
            return
        }
        
        withAnimation {
            makeMove(index: moveIndex)
            isThinking.toggle()
        }
    }
    
    // Легкий уровень: случайный ход
    private func selectEasyMove() -> Int {
        guard let move = possibleMoves.randomElement() else { return 0 }
        return move
    }
    
    // Средний уровень: попытка выиграть или блокировать игрока, иначе случайный ход
    private func selectMediumMove() -> Int {
        // Попытка выиграть
        if let winningMove = findWinningMove(for: player2) {
            return winningMove
        }
        
        // Блокировка игрока
        if let blockingMove = findWinningMove(for: player1) {
            return blockingMove
        }
        
        // Случайный ход
        return selectEasyMove()
    }
    
    // Поиск выигрышного хода для заданного игрока
    private func findWinningMove(for player: Player) -> Int? {
        for move in possibleMoves {
            var newBoard = gameBoard
            newBoard[move].player = player
            let tempMove = player.isCurrent ? player1.moves + [move] : player2.moves + [move]
            if isWinning(board: newBoard, moves: tempMove) {
                return move
            }
        }
        return nil
    }
    
    private func isWinning(board: [GameSquare], moves: [Int]) -> Bool {
        let winningCombinations = Move.winningMoves
        for combination in winningCombinations {
            if combination.allSatisfy(moves.contains) {
                return true
            }
        }
        return false
    }
    
    // Сложный уровень: алгоритм Minimax
    private func selectHardMove() -> Int {
        return 0
    }
}
