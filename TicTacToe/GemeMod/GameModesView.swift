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
            
            VStack(spacing: 20) {
                Text("Select Game")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.appBlack)
                
                Button {
                    navigator.push(Router.game(false))
                } label: {
                    MenuButtonsLabel(
                        title: "Single Player".localized,
                        iconName: "SinglePlayerButtonIcon",
                        colorButton: Color.buttonLightBackground
                    )
                }
                
                Button {
                    navigator.push(Router.game(true))
                } label: {
                    MenuButtonsLabel(
                        title: "Two Players".localized,
                        iconName: "TwoPlayersButtonIcon",
                        colorButton: Color.buttonLightBackground
                    )
                }
                
                Button {
                    navigator.push(Router.difficultyLevel)
                } label: {
                    MenuButtonsLabel(
                        title: "Difficulty Level".localized,
                        iconName: "DifficultyLevelButtonIcon",
                        colorButton: Color.buttonLightBackground
                    )
                }
                
                Button {
                    navigator.push(Router.leaderboard)
                } label: {
                    MenuButtonsLabel(
                        title: "Leaderboard".localized,
                        iconName: "LeaderboardButtonIcon",
                        colorButton: Color.leaderboardButton
                    )
                }
            }
            .padding(20)
            .background(.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
            .padding(50)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolBarNavigationItems(
                rightButtonHidden: false,
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
