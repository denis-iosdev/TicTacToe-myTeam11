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
    @ObservedObject var storageManager: StorageManager
    
    var audioPlayer: AudioPlayerProtocol
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                VStack(spacing: 45) {
                    
                    HStack { // FIXME: выглядить так что можно перенести в отдельную структуру
                        PlayerIconView(text: viewModel.player1.name, image: "Xskin\(storageManager.xSkin)")
                        
                        Spacer()
                        if storageManager.isTimerEnabled {
                            Text(viewModel.timeRemaining.timeFormatter)
                                .font(.system(size: 20, weight: .bold))
                        }
                        Spacer()
                        
                        PlayerIconView(text: viewModel.player2.name, image: "Oskin\(storageManager.oSkin)")
                    }
                    .foregroundStyle(.appBlack)
                    
                    HStack {
                        Image(viewModel.currentPlayer.gamePiece == .x
                              ? "Xskin\(storageManager.xSkin)"
                              : "Oskin\(viewModel.settings.oSkin)")
                        .frame(height: 53)
                        
                        Text("\(viewModel.currentPlayer.name) turn")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.appBlack)
                    }
                    
                    PlayingFieldView(settings: storageManager, viewModel: viewModel) // FIXME: выглядить так что можно не передавать storageManager, а передать значения в vm и потом достать из нее.
                    
                    Spacer()
                }
                .padding(.horizontal, 44)
            }
            .padding(.top, 25)
        }
        .onAppear {
            viewModel.reset()
            audioPlayer.playSound()
        }
        .onReceive(timer) { _ in
            viewModel.timerTick()
        }
        .onChange(of: viewModel.gameOver) { _ in
            viewModel.gameOver ? audioPlayer.stopSound() : ()
            viewModel.handleGameOver()
            
            guard let resultModel  = viewModel.resultModel else { return }
            let delay = viewModel.isDraw ? 0.5 : 1.2
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                navigator.push(Router.result(resultModel))
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolBarNavigationItems(leftAction: { navigator.pop() })
        }
    }
}
