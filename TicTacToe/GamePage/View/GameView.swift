//
//  GameView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 29.09.2024.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var settings: StorageManager
    @Environment(\.dismiss) var dismiss
    
    @State private var timerRunning = false
    @State private var timeRemaining = 0
    @State private var isResultActive = false
    
    @Binding var isGameActive: Bool
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 30) {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(.backButtonIcon)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 45) {
                        
                        HStack {
                            PlayerIconView(text: viewModel.player1.name, image: "xSkin\(settings.xSkin)")
                            
                            Spacer()
                            if settings.isTimerEnabled {
                                Text(timeRemaining.timeFormatter)
                                    .font(.system(size: 20, weight: .bold))
                            }
                            Spacer()
                            
                            PlayerIconView(text: viewModel.player2.name, image: "oSkin\(settings.oSkin)")
                        }
                        .foregroundStyle(.appBlack)

                    HStack {
                        Image(viewModel.currentPlayer.gamePiece == .x ? "xSkin\(settings.xSkin)" : "oSkin\(settings.oSkin)")
                        Text("\(viewModel.currentPlayer.name) turn")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.appBlack)
                    }
                    
                    PlayingFieldView(settings: settings, viewModel: viewModel)
                    
                    Spacer()
                }
                .padding(.horizontal, 44)
            }
            .padding(.top, 25)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            resetGame()
        }
        .onReceive(timer) { _ in
            timerSetting()
        }
        .onChange(of: viewModel.gameOver) { _ in
            if viewModel.gameOver {
                timerRunning = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    isResultActive = true
                }
            }
        }
        NavigationLink(destination: openResultView(), isActive: $isResultActive, label: {})
    }
    
    @ViewBuilder
    private func createResultView(text: String, image: String) -> some View {
        ResultView(isResultActive: $isResultActive,
                   isGameActive: $isGameActive,
                   text: text,
                   imageName: image,
                   playAgain: { resetGame() })
    }
    
    private func openResultView() -> some View {
        if viewModel.possibleMoves.isEmpty || (settings.isTimerEnabled && timeRemaining == 0) {
            return createResultView(text: "Draw!", image: "drawIcon")
        } else if viewModel.isTwoPlayerMode {
            return createResultView(text: "\(viewModel.winner?.name ?? "") win!", image: "winIcon")
        } else {
            if viewModel.winner == viewModel.player1 {
                return createResultView(text: "\(viewModel.player1.name) win!", image: "winIcon")
            } else {
                return createResultView(text: "\(viewModel.player1.name) Lose!", image: "loseIcon")
            }
        }
    }
    
    private func timerSetting() {
        if settings.isTimerEnabled && timerRunning && timeRemaining > 0 {
            timeRemaining -= 1
        } else if settings.isTimerEnabled && timerRunning && timeRemaining == 0 {
            viewModel.gameOver = true
            timerRunning = false
        }
    }
    
    private func resetGame() {
        viewModel.reset()
        timeRemaining = settings.timerSeconds
        timerRunning = settings.isTimerEnabled
    }
}
