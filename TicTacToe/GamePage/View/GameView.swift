//
//  GameView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 29.09.2024.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var timerRunning = false
    @State private var timeRemaining = 0
    @State private var showResult = false
    
    let isTwoPlayerMode: Bool
    
    var isTimerOn: Bool = true
    var initialTime: Int = 65
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(isTwoPlayerMode: Bool) {
        self.isTwoPlayerMode = isTwoPlayerMode
        self.viewModel = GameViewModel(isTwoPlayerMode: isTwoPlayerMode)
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 45) {
                
                HStack {
                    PlayerIconView(text: viewModel.player1.name, isTimerOn: isTimerOn, image: viewModel.player1.gamePiece.rawValue)
                    
                    Spacer()
                    if isTimerOn {
                        Text(timeRemaining.timeFormatter)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    
                    PlayerIconView(text: viewModel.player2.name, isTimerOn: isTimerOn, image: viewModel.player2.gamePiece.rawValue)
                }
                .foregroundStyle(.appBlack)
                
                HStack {
                    Image(viewModel.currentPlayer.gamePiece.rawValue)
                    Text("\(viewModel.currentPlayer.name) turn")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.appBlack)
                }
                
                PlayingFieldView(viewModel: viewModel)
                
                Spacer()
            }
            .padding(.horizontal, 44)
            .padding(.top, 20)
        }
        .onAppear {
            resetGame()
        }
        .onReceive(timer) { _ in
            timerSetting()
        }
        .onChange(of: viewModel.gameOver) { _ in
            if viewModel.gameOver {
                timerRunning = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showResult = true
                }
            }
        }
        .fullScreenCover(isPresented: $showResult) {
            if viewModel.possibleMoves.isEmpty || (isTimerOn && timeRemaining == 0) {
                ResultView(text: "Draw!", imageName: "drawIcon", playAgain: { resetGame() })
            } else if isTwoPlayerMode {
                ResultView(text: "\(viewModel.winner?.name ?? "") win!", imageName: "winIcon", playAgain: { resetGame() })
            } else {
                if viewModel.winner == viewModel.player1 {
                    ResultView(text: "\(viewModel.player1.name) win!", imageName: "winIcon", playAgain: { resetGame() })
                } else {
                    ResultView(text: "\(viewModel.player1.name) Lose!", imageName: "loseIcon", playAgain: { resetGame() })
                }
            }
        }
    }
    
    private func timerSetting() {
        if timerRunning && timeRemaining > 0 {
            timeRemaining -= 1
        } else if timerRunning && timeRemaining == 0 {
            viewModel.gameOver = true
            timerRunning = false
        }
    }
    
    private func resetGame() {
        viewModel.reset()
        timeRemaining = initialTime
        timerRunning = isTimerOn
    }
}
