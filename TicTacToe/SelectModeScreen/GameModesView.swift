//
//  GameModesView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI

struct GameModesView: View {
    
    @State private var isSinglePlayerActive = false
    @State private var isTwoPlayerActive = false
    @State private var isResultActive = false
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Select Game")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    
                    NavigationLink(
                        destination: GameView(viewModel: GameViewModel(isTwoPlayerMode: true), isResultActive: $isResultActive, isGameActive: $isSinglePlayerActive),
                        isActive: $isSinglePlayerActive,
                        label: {
                            GameModeLabel(title: "Two Players", iconName: "TwoPlayersButtonIcon")
                        })
                    
                    NavigationLink(
                        destination: GameView(viewModel: GameViewModel(isTwoPlayerMode: false), isResultActive: $isResultActive, isGameActive: $isTwoPlayerActive),
                        isActive: $isTwoPlayerActive,
                        label: {
                            GameModeLabel(title: "Single Player", iconName: "SinglePlayerButtonIcon")
                        })
                    
                }
                .padding(20)
                .background(.white)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                
                Spacer()
            }
            .customNavigationRightButtonHidden(false)
        }
    }
}

#Preview {
    GameModesView()
}
