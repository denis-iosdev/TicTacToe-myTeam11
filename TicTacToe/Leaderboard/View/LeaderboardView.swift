//
//  LeaderboardView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 05.10.2024.
//

import SwiftUI
import NavigationBackport

struct LeaderboardView: View {
    @ObservedObject var storageManager: StorageManager
    @EnvironmentObject var navigator: PathNavigator
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            let sortedTimes = storageManager.resultsTime.sorted(by: { $0 < $1 })
            
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
                .padding(.horizontal, 21)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolBarNavigationItems(title: "Leaderboard", leftAction: { navigator.pop() })
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
