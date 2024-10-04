//
//  DifficultyLevelView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 04.10.2024.
//

import SwiftUI
import NavigationBackport

struct DifficultyLevelView: View {
    @EnvironmentObject var navigator: PathNavigator
    
    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    Text("Select Game")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.appBlack)
                    
                    Button {
                        navigator.push(Router.game(false, .easy))
//                        DifficultyLevel.selectedLevel = .easy
                    } label: {
                        DifficultyButton(text: "Easy")
                    }

                    Button {
                        navigator.push(Router.game(false, .medium))
//                        DifficultyLevel.selectedLevel = .medium
                    } label: {
                        DifficultyButton(text: "Medium")
                    }
                    
                    Button {
                        navigator.push(Router.game(false, .hard))
//                        DifficultyLevel.selectedLevel = .hard
                    } label: {
                        DifficultyButton(text: "Hard")
                    }
                }
                .padding(20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 10)
            }
            .padding(52)
        }
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
