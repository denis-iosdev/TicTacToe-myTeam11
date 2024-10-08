//
//  LeaderboardView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 05.10.2024.
//

import SwiftUI
import NavigationBackport

// FIXME: -
// - можно перенести логику в vm (будет маленькая, но все же)
// - в LeaderboardView body сократить размер вложенных вью до нескольких строк чтоб проще читалось условие if else

struct LeaderboardView: View {
    @ObservedObject var storageManager: StorageManager
    @EnvironmentObject var navigator: PathNavigator
    
    @State private var isPresentAlert = false
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            let sortedTimes = storageManager.resultsTime.sorted(by: { $0 < $1 })
            
            if !storageManager.resultsTime.isEmpty {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(Array(sortedTimes.enumerated()), id: \.offset) { index, time in
                            HStack {
                                Text("\(index + 1)")
                                    .leaderboardText(index: index)
                                    .clipShape(Circle())
                                
                                Text(index == 0 ? "Best time \(time.timeFormatter)" : "Time \(time.timeFormatter)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .leaderboardText(index: index)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 21)
                }
            } else {
                VStack(spacing: 40) {
                    Text("No game history\nwith turn on time")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.appBlack)
                    Image(.emptyLeaderboard)
                }
            }
            
        }
        .alert(isPresented: $isPresentAlert) {
            Alert(title: Text("Clear Leaderboard?"),
                  message: Text("Are you sure you want to clear the leaderboard?"),
                  primaryButton: .default(Text("Cancel")),
                  secondaryButton: .destructive(Text("Delete"), action: {
                withAnimation(.easeInOut(duration: 1)) {
                    storageManager.clearLeaderboard()
                }
            })
            )
        }
        
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolBarNavigationItems(
                title: "Leaderboard".localized,
                rightButtonState: .basket,
                rightButtonHidden: storageManager.resultsTime.isEmpty,
                leftAction: { navigator.pop() }, rightAction: {
                    isPresentAlert.toggle()
             })
        }
    }
}

struct LeaderboardText: ViewModifier {
    let index: Int
    
    func body(content: Content) -> some View {
        content
            .padding(24)
            .font(.system(size: 20))
            .foregroundStyle(.appBlack)
            .background(index == 0 ? .appPurple : .lightBlue)
    }
}
