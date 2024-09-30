//
//  GameView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 29.09.2024.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel(isTwoPlayerMode: false)
    @Environment(\.dismiss) var dismiss
    
    @State private var timerRunning = false
    @State private var timeRemaining = 0
    
    var isTimerOn: Bool = true
    var initialTime: Int = 65
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timeFormatter: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 45) {
                
                VStack(spacing: 30) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundStyle(.appBlack)
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        PlayerIconView(text: viewModel.player1.name, isTimerOn: isTimerOn, image: viewModel.player1.gamePiece.image)
                        
                        Spacer()
                        if isTimerOn {
                            Text(timeFormatter)
                                .font(.system(size: 20, weight: .bold))
                        }
                        Spacer()
                        
                        PlayerIconView(text: viewModel.player1.name, isTimerOn: isTimerOn, image: viewModel.player2.gamePiece.image)
                    }
                    .foregroundStyle(.appBlack)
                }
                
                HStack {
                    Image(viewModel.currentPlayer.gamePiece.image)
                    Text("\(viewModel.currentPlayer.name) turn")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.appBlack)
                }
                
                PlayingFieldView(viewModel: viewModel)
                
                VStack {
                    if viewModel.gameOver {
                        Button("New Game") {
                            viewModel.reset()
                            timeRemaining = initialTime
                            timerRunning = isTimerOn
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 44)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.reset()
            timeRemaining = initialTime
            timerRunning = isTimerOn
        }
        .onReceive(timer) { _ in
            if self.timerRunning && self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else if self.timerRunning && self.timeRemaining == 0 {
                viewModel.gameOver = true
                timerRunning = false
            }
        }
        .onChange(of: viewModel.gameOver) { _ in
            if viewModel.gameOver {
                timerRunning = false
            }
        }
    }
}
