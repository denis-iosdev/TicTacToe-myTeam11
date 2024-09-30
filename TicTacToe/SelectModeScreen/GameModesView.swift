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
                    
                }
                .frame(width: 285, height: 247)
                .background(.white)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                
                Spacer()
            }
        }
    }
}

#Preview {
    GameModesView()
}
