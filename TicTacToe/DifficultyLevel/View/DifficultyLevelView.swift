//
//  DifficultyLevelView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 04.10.2024.
//

import SwiftUI
import NavigationBackport

struct DifficultyLevelView: View {
    private let title: String = "Choose level".localized
    @ObservedObject var storageManager: StorageManager
    @EnvironmentObject var navigator: PathNavigator
    
    @State private var difflvl: DifficultyLevel = .easy
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    Text(title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.appBlack)
                    
                    DifficultyButton(text: .easy, difflvl) {
                        storageManager.settings.difficultyLevel = .easy
                        navigator.push(Router.game(false))
                    }
                    DifficultyButton(text: .medium, difflvl) {
                        storageManager.settings.difficultyLevel = .medium
                        navigator.push(Router.game(false))
                    }
                    DifficultyButton(text: .hard, difflvl) {
                        storageManager.settings.difficultyLevel = .hard
                        navigator.push(Router.game(false))
                    }
                }
                .padding(20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.black.opacity(0.2), radius: 10)
            }
            .padding(52)
        }
        .onAppear {
            if let value = DifficultyLevel(rawValue: storageManager.difficultyLevelRawValue) {
                difflvl = value
            }
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

// MARK: - DifficultyButton

fileprivate struct DifficultyButton: View {
    let text: DifficultyLevel
    let difflvl: DifficultyLevel
    let action: VoidBlock
    
    init(
        text: DifficultyLevel,
        _ difflvl: DifficultyLevel,
        action: @escaping VoidBlock
    ) {
        self.text = text
        self.difflvl = difflvl
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text.title.localized)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.appBlack)
                .background(RoundedRectangle(cornerRadius: 30).fill(isSelected ? .appPurple : .lightBlue))
        }
    }
    
    private var isSelected: Bool {
        text == difflvl
    }
}
