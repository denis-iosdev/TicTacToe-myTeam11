//
//  GameModesView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI

struct GameModesView: View {
    @StateObject private var settings = StorageManager()
    //    @Environment (\.presentationMode) var presentationMode
    @State private var settingViewIsOn: Bool = false
    @State private var isSinglePlayerActive = false
    @State private var isTwoPlayerActive = false
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            NavigationView {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            settingViewIsOn = true
                        } label: {
                            Image(.settingIcon)
                        }
                        .fullScreenCover(isPresented: $settingViewIsOn) {
                            SettingsView(settings: settings)
                        }
                    }

                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Select Game")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundStyle(.appBlack)
                        
                        NavigationLink(
                            destination: GameView(viewModel: GameViewModel(isTwoPlayerMode: false),
                                                  settings: settings,
                                                  isGameActive: $isSinglePlayerActive),
                            isActive: $isSinglePlayerActive,
                            label: {
                                GameModeLabel(title: "Single Player", iconName: "SinglePlayerButtonIcon")
                            })
                        
                        NavigationLink(
                            destination: GameView(viewModel: GameViewModel(isTwoPlayerMode: true),
                                                  settings: settings,
                                                  isGameActive: $isTwoPlayerActive),
                            
                            isActive: $isTwoPlayerActive,
                            label: {
                                GameModeLabel(title: "Two Players", iconName: "TwoPlayersButtonIcon")
                            })
                        
                    }
                    .padding(20)
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    
                    Spacer()
                }
                .padding(.horizontal, 21)
            }
            
        }
    }
}

#Preview {
    NavigationView {
        GameModesView()
    }
}
