//
//  GameModesView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI
import NavigationBackport

struct GameModesView: View {
    @EnvironmentObject var navigator: PathNavigator

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            Spacer()
            
            VStack(spacing: 20) {
                Text("Select Game")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.appBlack)
                
                Button {
                    navigator.push(Router.game(false))
                } label: {
                    MenuButtonsLabel(
                        title: "Single Player",
                        iconName: "SinglePlayerButtonIcon",
                        colorButton: Color.buttonLightBackground
                    )
                }
                
                Button {
                } label: {
                    MenuButtonsLabel(
                        title: "Two Players",
                        iconName: "TwoPlayersButtonIcon",
                        colorButton: Color.buttonLightBackground
                    )
                }
                
                Button {
                    // TODO: open modally DifficultyLevel
                } label: {
                    MenuButtonsLabel(
                        title: "Difficulty Level",
                        iconName: "DifficultyLevelButtonIcon",
                        colorButton: Color.buttonLightBackground
                    )
                }
                
                Button {
                    navigator.push(Router.leaderboard)
                } label: {
                    MenuButtonsLabel(
                        title: "Leaderboard",
                        iconName: "LeaderboardButtonIcon",
                        colorButton: Color.leaderboardButton
                    )
                }
            }
            .padding(20)
            .background(.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(
                rightButtonHiddeb: false,
                leftAction: { navigator.pop()},
                rightAction: { navigator.push(Router.setting) }
            )
        }
    }
}


#Preview {
    NavigationView {
        GameModesView()
    }
}
