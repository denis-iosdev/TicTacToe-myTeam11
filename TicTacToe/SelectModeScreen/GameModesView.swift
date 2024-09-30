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
                
                VStack {
                    Text("Select Game")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    
                    NavigationLink {
                        // set single player mode
                    } label: {
                        Label("Single Player", image: "SinglePlayerButtonIcon")
                            .padding()
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                            .background(Color(UIColor(red: 0xE6 / 255, green: 0xE9 / 255, blue: 0xF9 / 255, alpha: 1.0)))
                            .cornerRadius(30)
                    }
                }
                .frame(width: 285, height: 247)
                .background(.white)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                
                Spacer()
            }
            .background(Color(UIColor(red: 0xF5 / 255, green: 0xF7 / 255, blue: 0xFF / 255, alpha: 1.0)))
        }
    }
}

#Preview {
    GameModesView()
}
