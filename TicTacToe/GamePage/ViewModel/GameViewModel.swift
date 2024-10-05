//
//  GameService.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 30.09.2024.
//

import SwiftUI
import NavigationBackport

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
//    var difficultyLevel: DifficultyLevel?
    
    var currentPlayer: Player {
        player1.isCurrent ? player1 : player2
    }
    
    var boardDisabled: Bool {
        gameOver || isThinking || timeRemaining == 0
    }
    
    // MARK: - Initializer
    init(isTwoPlayerMode: Bool, settings: StorageManager) {
        self.isTwoPlayerMode = isTwoPlayerMode
        self.settings = settings
        self.player1 = Player(gamePiece: .x, name: isTwoPlayerMode ? "Player One" : "You")
        self.player2 = Player(gamePiece: .o, name: isTwoPlayerMode ? "Player Two" : "Computer")
        
        settings.isTimerEnabled ? startTimer() : nil
    }
    
    // MARK: - Methods
    func handleGameOver() {
        if gameOver {
            openResultView()
            saveGameResult()
        }
    }
    
    func saveGameResult() {
        guard settings.isTimerEnabled else { return }
        settings.addResultTime(settings.timerSeconds - timeRemaining)
    }
    
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
        
        switch settings.difficultyLevelRawValue {
        case "easy":
            moveIndex = selectEasyMode()
        case "medium":
            moveIndex = selectMediumMode()
        case "hard":
            moveIndex = selectHardMode()
        default:
            return
        }
        
        withAnimation {
            makeMove(index: moveIndex)
            isThinking.toggle()
        }
    }
    
    // Легкий уровень: случайный ход
    private func selectEasyMode() -> Int {
        // Проверяем не равен ли рандомный элемент из массива possibleMoves nil
        guard let move = possibleMoves.randomElement() else { return 0 }
        // Возвращаем рандомный элемент
        return move
    }
    
    // Средний уровень: попытка выиграть или блокировать игрока, иначе случайный ход
    private func selectMediumMode() -> Int {
        // Попытаться выиграть: Если у компьютера есть возможность выиграть за текущий ход, он делает этот ход.
        if let winningMove = findWinningMove(for: player2) {
            return winningMove
        }
        
        // Блокировать игрока: Если игрок может выиграть за следующий ход, компьютер блокирует этот ход.
        if let blockingMove = findWinningMove(for: player1) {
            return blockingMove
        }
        
        // Случайный ход: Если ни одно из вышеупомянутых условий не выполнено, компьютер делает случайный ход.
        return selectEasyMode()
    }
    
    // Эта функция ищет выигрышный ход для заданного игрока (player1 или player2). Она симулирует каждый возможный ход и проверяет, приводит ли он к победе.
    private func findWinningMove(for player: Player) -> Int? {
        
        // Проходит по каждому доступному ходу из массива possibleMoves, который содержит индексы свободных клеток на доске.
        for move in possibleMoves {
            
            // Создает копию текущего состояния доски в newBoard.
            var newBoard = gameBoard
            
            // Симулирует ход заданного игрока, помечая клетку move своим символом.
            newBoard[move].player = player
            
            // Создает временный массив ходов для игрока, добавляя симулированный ход к его текущим ходам.
            let tempMove = (player.gamePiece == player1.gamePiece) ? player1.moves + [move] : player2.moves + [move]
            
            // Вызывает функцию isWinning, чтобы проверить, приводит ли симулированный ход к победе
            if isWinning(board: newBoard, moves: tempMove) {
                // Возвращает этот ход как выигрышный
                return move
            }
        }
        // Если ни один из ходов не приводит к победе, функция возвращает nil.
        return nil
    }
    
    // Эта функция проверяет, приводит ли заданный набор ходов (moves) к победе на доске board.
    private func isWinning(board: [GameSquare], moves: [Int]) -> Bool {
        
        // Извлекает все возможные выигрышные комбинации (тройки индексов), определенные в Move.winningMoves.
        let winningCombinations = Move.winningMoves
        
        // Итерирует по каждой возможной выигрышной комбинации.
        for combination in winningCombinations {
            
            // Использует метод allSatisfy для проверки, содержатся ли все элементы комбинации в массиве moves.
            if combination.allSatisfy(moves.contains) {
                
                // Если условие выполняется, функция возвращает true
                return true
            }
        }
        
        // Если ни одна комбинация не приводит к победе, функция возвращает false
        return false
    }
    
    // MARK: - Hard Level: Minimax Algorithm
    
    // Ищет лучший ход для компьютера, используя minimax.
    private func selectHardMode() -> Int {
        
        // Инициализируется как минимальное возможное целое число (Int.min), будет хранить наилучшую оценку, найденную для ходов.
        var bestScore = Int.min
        
        // Инициализируется как -1, будет хранить индекс лучшего хода.
        var bestMove = -1
        
        for move in possibleMoves {
            // Создаем копию текущей доски, чтобы не изменять оригинал при симуляции ходов.
            var newBoard = gameBoard
            
            // На копии доски делаем ход компьютера (player2) в текущую свободную клетку (index).
            newBoard[move].player = player2
            
            // Вызываем функцию minimax, передавая ей обновленную доску, начальную глубину рекурсии (0) и устанавливаем isMaximizing в false, так как следующий ход будет за игроком (минимизирующим игроком).
            let score = minimax(board: newBoard, depth: 0, isMaximizing: false)
            
            // Если оценка текущего хода (score) лучше, чем bestScore, обновляем bestScore и bestMove.
            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }
        
        // После проверки всех возможных ходов, возвращаем индекс лучшего хода, который будет сделан компьютером.
        return bestMove
    }
    
    // Рекурсивно оценивает все возможные ходы и возвращает оценку для текущего игрока.
    private func minimax(board: [GameSquare], depth: Int, isMaximizing: Bool) -> Int {
        // Вычитаем или прибавляем depth, чтобы предпочесть победу в меньшем количестве ходов.
        
        // Вызываем checkWinner(for:) для проверки, есть ли победитель на текущей доске.
        if let winner = checkWinner(for: board) {
            
            // Если победил компьютер (player2), возвращаем положительную оценку (10 - depth).
            if winner.gamePiece == player2.gamePiece {
                return 10 - depth // Победа компьютера
                
                // Если победил игрок (player1), возвращаем отрицательную оценку (depth - 10)
            } else if winner.gamePiece == player1.gamePiece {
                return depth - 10 // Победа игрока
            }
            
            // Если доска заполнена и нет победителя, возвращаем 0 (ничья)
        } else if isBoardFull(board: board) {
            return 0 // Ничья
        }
        
        // Перебор всех возможных ходов:
        
        //Для максимизирующего игрока (компьютера):
        if isMaximizing {
            
            // Инициализируем bestScore как минимальное целое число.
            var bestScore = Int.min
            
            // Проходим по всем пустым клеткам на доске.
            for index in 0..<board.count where board[index].player == nil {
                
                // Создаем копию текущей доски, чтобы не изменять оригинал при симуляции ходов.
                var newBoard = board
                
                // Делаем ход за компьютера (player2)
                newBoard[index].player = player2
                
                // Рекурсивно вызываем minimax для нового состояния доски, увеличивая глубину (depth + 1) и переключая isMaximizing на false (теперь ход минимизирующего игрока)
                let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: false)
                
                // Обновляем bestScore, выбирая максимальное значение из текущего bestScore и score, полученного из рекурсивного вызова.
                bestScore = max(bestScore, score)
            }
            // Возвращаем bestScore после перебора всех возможных ходов.
            return bestScore
            
        // Для минимизирующего игрока (игрока):
        } else {
            // Инициализируем bestScore как максимальное целое число.
            var bestScore = Int.max
            
            // Проходим по всем пустым клеткам на доске.
            for index in 0..<board.count where board[index].player == nil {
                
                // Создаем копию текущей доски, чтобы не изменять оригинал при симуляции ходов.
                var newBoard = board
                
                // Делаем ход за игрока (player1)
                newBoard[index].player = player1
                
                // Рекурсивно вызываем minimax для нового состояния доски, увеличивая глубину (depth + 1) и переключая isMaximizing на true (теперь ход максимизирующего игрока).
                let score = minimax(board: newBoard, depth: depth + 1 , isMaximizing: true)
                
                // Обновляем bestScore, выбирая минимальное значение из текущего bestScore и score, полученного из рекурсивного вызова.
                bestScore = min(bestScore, score)
            }
            
            // Возвращаем bestScore после перебора всех возможных ходов.
            return bestScore
        }
        
        //        Объяснение оценки:
        ///       Победа компьютера: Оценивается как 10 - depth.
        ///       Чем меньше depth, тем выше оценка, что предпочтительнее (быстрая победа).
        ///       Победа игрока: Оценивается как depth - 10.
        ///       Чем больше depth, тем выше значение (меньше отрицательное число), но все еще отрицательное, так как это нежелательно для компьютера.
        ///       Ничья: Оценивается как 0.
        ///       Нейтральный результат.
    }
    
    // Проверить, есть ли победитель на текущей доске и вернуть победившего игрока (Player?)
    private func checkWinner(for board: [GameSquare]) -> Player? {
        
        // Проходим по всем возможным выигрышным комбинациям, определенным в Move.winningMoves.
        for combination in Move.winningMoves {
            
            // Используем опциональное связывание (if let) для безопасного извлечения игроков из клеток комбинации.
            if let firstPlayer = board[combination[0]].player,
               let secondPlayer = board[combination[1]].player,
               let thirdPlayer = board[combination[2]].player,
               
                // Сравниваем gamePiece (.x или .o) каждого игрока, чтобы убедиться, что они одинаковые.
               firstPlayer.gamePiece == secondPlayer.gamePiece,
               secondPlayer.gamePiece == thirdPlayer.gamePiece {
                
                // Если все условия выполняются, возвращаем firstPlayer как победителя.
                return firstPlayer
            }
        }
        
        // Если ни одна комбинация не привела к победе, возвращаем nil.
        return nil
    }
    
    // Проверить, заполнена ли доска полностью (нет ли свободных клеток).
    private func isBoardFull(board: [GameSquare]) -> Bool {
        // Если находим хотя бы одну клетку, где player == nil, функция contains вернет true.
        return !board.contains { $0.player == nil}
        // Мы инвертируем результат с помощью !, чтобы получить true, когда доска полна, и false, когда есть хотя бы одна пустая клетка.
    }
}
