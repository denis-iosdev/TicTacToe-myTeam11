//
//  ContentView.swift
//  TicTacToe
//
//  Created by Денис Гиндулин on 29.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isTwoPlayerMode: Bool = false
    @State private var initialTime: Int = 65
    @State private var isTimerOn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Two player mode", isOn: $isTwoPlayerMode)
                Toggle("Turn on the time", isOn: $isTimerOn)
                
                NavigationLink("Go to game page") {
                    GameView(viewModel: GameViewModel(isTwoPlayerMode: isTwoPlayerMode), isTimerOn: isTimerOn, initialTime: initialTime)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
