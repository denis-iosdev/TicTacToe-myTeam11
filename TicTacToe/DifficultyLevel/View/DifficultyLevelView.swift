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
            Color.lightBlue
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
                        DifficultyButton(text: "Easy")
                    }

                    Button {
                        navigator.push(Router.game(false, .medium))
                        storageManager.settings.difficultyLevel = .medium
                    } label: {
                        DifficultyButton(text: "Medium")
                    }
                    
                    Button {
                        navigator.push(Router.game(false, .hard))
                        storageManager.settings.difficultyLevel = .hard
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

//struct DifficultyLevelView: View {
//    @ObservedObject private var storageManager: StorageManager
//    
//    var body: some View {
//        ZStack {
//            Color.background.ignoresSafeArea()
//            
//            VStack(spacing: 20) {
//                Text("Select Game")
//                    .font(.system(size: 24, weight: .medium))
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.appBlack)
//                
//                ForEach(DifficultyLevel.allCases) { level in
//                    let isChoosed = level == storageManager.settings.difficultyLevel
//                    
//                    Button {
//                        storageManager.settings.difficultyLevel = level
//                    } label: {
//                        Text(level.rawValue)
//                            .font(.system(size: 20, weight: .medium))
//                            .foregroundStyle(isChoosed ? .white : .black)
//                            .padding()
//                            .frame(minWidth: 260)
//                            .background(isChoosed
//                                        ? Color.leaderboardButton
//                                        : Color.buttonLightBackground)
//                            .cornerRadius(30)
//                    }
//                    
//                }
//            }
//            .padding(20)
//            .background(.white)
//            .cornerRadius(30)
//            .shadow(color: Color.black.opacity(0.15), radius: 10)
//        }
//    }
//}
