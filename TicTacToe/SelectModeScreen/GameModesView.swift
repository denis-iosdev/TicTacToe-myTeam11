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
            }
        }
    }
}

#Preview {
    GameModesView()
}
