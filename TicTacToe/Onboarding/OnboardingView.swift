//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 29.09.24.
//

import SwiftUI
import NavigationBackport

struct OnboardingView: View {
    @StateObject var storageManager = StorageManager()
    @EnvironmentObject var navigator: PathNavigator
    @State private var settingViewIsOn: Bool = false
    @State private var helpViewIsOn: Bool = false
    
    var body: some View {
        NBNavigationLink(value: Router.help) {
            EmptyView()
        }
        NBNavigationLink(value: Router.setting) {
            EmptyView()
        }
        OnboardingContentView()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolBarNavigationItems(
                    leftButtonState: .help,
                    rightButtonHidden: false,
                    leftAction: {
                        navigator.push(Router.help)
                    },
                    rightAction: {
                        navigator.push(Router.setting)
                    }
                )
            }
            .nbNavigationDestination(for: Router.self) { value in
                switch value {
                case .onbording:
                    OnboardingView()
                case .help:
                    Text("Help")
                case .setting:
                    SettingsView(storageManager: storageManager)
                case .gameMod:
                    GameModesView()
                case .game(let isTwoPlayer):
                    let gameVM = GameViewModel(isTwoPlayerMode: isTwoPlayer)
                    GameView(viewModel: gameVM, settings: storageManager)
                case .difficultyLevel:
                    DifficultyLevelView()
                case .leaderboard:
                    Text("leaderboard")
                case .result(let resultGame):
                    ResultView(result: resultGame)
                }
            }
    }
}

//#Preview {
//    NavigationView {
//        OnboardingView()
//    }
//}

struct OnboardingContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private let buttonTitle: String = "Let's play"
    private let titleText: String = "TIC-TAC-TOE"
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(uiImage: .logo)
                .padding(.horizontal, 60)
            
            Text(titleText)
                .font(.title)
                .bold()
                .padding(.top, 30)
            
            Spacer()
            
            NBNavigationLink(value: Router.gameMod) {
                MainButtonView(title: buttonTitle, style: .fill)
                    .padding(.bottom, isSmallScreen() ? 20 : 0)
            }
        }
    }
    
    func isSmallScreen() -> Bool {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight <= 667
    }
}
