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
                    GameModeLabel(
                        title: "Single Player",
                        iconName: "SinglePlayerButtonIcon"
                    )
                }
                
                Button {
                    navigator.push(Router.game(true))
                } label: {
                    GameModeLabel(
                        title: "Two Players",
                        iconName: "TwoPlayersButtonIcon"
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
