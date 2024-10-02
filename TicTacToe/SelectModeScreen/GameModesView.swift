//
//  GameModesView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI

struct GameModesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Select Game")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                        
                        NavigationLink {
                            GameView(viewModel: GameViewModel(isTwoPlayerMode: false))
                        } label: {
                            GameModeLabel(title: "Single Player", iconName: "SinglePlayerButtonIcon")
                            
                        }
                        
                        NavigationLink {
                            GameView(viewModel: GameViewModel(isTwoPlayerMode: true))
                        } label: {
                            GameModeLabel(title: "Two Players", iconName: "TwoPlayersButtonIcon")
                            
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image("SettingButtonIcon")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GameModesView()
}
