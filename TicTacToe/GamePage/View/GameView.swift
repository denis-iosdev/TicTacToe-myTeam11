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
    
    let isTwoPlayerMode: Bool
    
    var isTimerOn: Bool = true
    var initialTime: Int = 65
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timeFormatter: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
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
                        Text(timeFormatter)
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
            viewModel.reset()
            timeRemaining = initialTime
            timerRunning = isTimerOn
        }
        .onReceive(timer) { _ in
            timerSetting()
        }
        .onChange(of: viewModel.gameOver) { _ in
            if viewModel.gameOver {
                timerRunning = false
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
}
