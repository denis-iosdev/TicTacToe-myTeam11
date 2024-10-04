//
//  DifficultyLevelView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 04.10.2024.
//

import SwiftUI
import NavigationBackport

struct DifficultyLevelView: View {
    @ObservedObject var storageManager: StorageManager
    @EnvironmentObject var navigator: PathNavigator
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    Text("Select Game")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.appBlack)
                    
                    Button {
                        navigator.push(Router.game(false, .easy))
                        storageManager.settings.difficultyLevel = .easy
                    } label: {
                        DifficultyButton(text: "Easy",
                                         isSelected: storageManager.difficultyLevelRawValue == "easy")
                    }

                    Button {
                        navigator.push(Router.game(false, .medium))
                        storageManager.settings.difficultyLevel = .medium
                    } label: {
                        DifficultyButton(text: "Medium",
                                         isSelected: storageManager.difficultyLevelRawValue == "medium")
                    }
                    
                    Button {
                        navigator.push(Router.game(false, .hard))
                        storageManager.settings.difficultyLevel = .hard
                    } label: {
                        DifficultyButton(text: "Hard",
                                         isSelected: storageManager.difficultyLevelRawValue == "hard")
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
