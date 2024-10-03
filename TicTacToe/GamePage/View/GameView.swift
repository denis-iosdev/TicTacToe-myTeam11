//
//  GameView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 29.09.2024.
//

import SwiftUI
import NavigationBackport

struct GameView: View {
    @EnvironmentObject var navigator: PathNavigator
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var settings: StorageManager
    
    @State private var timerRunning = false
    @State private var timeRemaining = 0
    
    @StateObject private var audioPlayer = AudioPlayer() // Создаем экземпляр аудио-плеера
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                VStack(spacing: 45) {
                        
                        HStack {
                            PlayerIconView(text: viewModel.player1.name, image: "Xskin\(settings.xSkin)")
                            
                            Spacer()
                            if settings.isTimerEnabled {
                                Text(timeRemaining.timeFormatter)
                                    .font(.system(size: 20, weight: .bold))
                            }
                            Spacer()
                            
                            PlayerIconView(text: viewModel.player2.name, image: "Oskin\(settings.oSkin)")
                        }
                        .foregroundStyle(.appBlack)

                    HStack {
                        Image(viewModel.currentPlayer.gamePiece == .x ? "Xskin\(settings.xSkin)" : "Oskin\(settings.oSkin)")
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
                    openResultView()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolBarNavigationItems(leftAction: { navigator.pop() })
        }
        
        .onAppear {
            audioPlayer.playSound() // Воспроизведение музыки при появлении экрана
        }
        .onDisappear {
            audioPlayer.stopSound() // Остановка музыки при исчезновении экрана
        }
        
    }
    
    private func createResultView(text: String, result: ResultGameModel.Result) {
        let result = ResultGameModel(userName: text, result: result)
        navigator.push(Router.result(result))
    }
    
    private func openResultView() {
        if viewModel.possibleMoves.isEmpty || (settings.isTimerEnabled && timeRemaining == 0) {
            createResultView(text: "Draw!", result: .draw)
        } else if viewModel.isTwoPlayerMode {
            createResultView(text: "\(viewModel.winner?.name ?? "") win!", result: .win)
        } else {
            if viewModel.winner == viewModel.player1 {
                createResultView(text: "\(viewModel.player1.name) win!", result: .win)
            } else {
                createResultView(text: "\(viewModel.player1.name) Lose!", result: .lose)
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
