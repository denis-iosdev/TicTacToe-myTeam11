//
//  ResultView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 02.10.2024.
//

import SwiftUI
import NavigationBackport

struct ResultView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navigator: PathNavigator

    let result: ResultGameModel

    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text(result.userName)
                    .font(.system(size: 20, weight: .bold))
                ResultImage(retult: result.result)
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button {
                    navigator.pop()
                } label: {
                    Text("Play again")
                        .resultButton(color: .playAgainButton)
                        .background(RoundedRectangle(cornerRadius: 30).fill(.appBlue))
                }
                
                Button {
                    navigator.popTo(Router.gameMod)
                } label: {
                    Text("Back")
                        .resultButton(color: .appBlue)
                        .background(RoundedRectangle(cornerRadius: 30).fill(colorScheme == .dark ? .basicBlue : .clear))
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 2).fill(.basicBlue)
                        }
                }
            }
            .font(.system(size: 20, weight: .medium))
        }
        .navigationBarHidden(true)
        .padding(.horizontal, 21)
        .padding(.bottom, 18)
    }
}

struct ResultImage: View {
    let retult: ResultGameModel.Result
    
    var body: some View {
        switch retult {
        case .win:
            image
        case .lose:
            image
        case .draw:
            image
        }
    }
    
    private var image: some View {
        Image(retult.imageName)
            .resizable()
            .frame(width: 230, height: 230)
    }
}
