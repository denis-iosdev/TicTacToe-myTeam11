//
//  GameModesView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 30/09/2024.
//

import SwiftUI

struct GameModesView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        // go to setting screen
                    } label: {
                        Image("SettingButtonIcon")
                            .padding()
                    }
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Select Game")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    
                    NavigationLink {
                        // set single player mode
                    } label: {
                        GameModeLabel(title: "Single Player", iconName: "SinglePlayerButtonIcon")
                    }
                    
                    NavigationLink {
                        // set two players mode
                    } label: {
                        GameModeLabel(title: "Two Players", iconName: "TwoPlayersButtonIcon")
                    }
                }
                .frame(width: 285, height: 247)
                .background(.white)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                
                Spacer()
            }
            .background(Color.background)
        }
    }
}

#Preview {
    GameModesView()
}
