//
//  RulesView.swift
//  TicTacToe
//
//  Created by Денис Гиндулин on 30.09.2024.
//

import SwiftUI
import NavigationBackport

struct RulesView: View {
    @EnvironmentObject var navigator: PathNavigator
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.97, blue: 1)
            .ignoresSafeArea()
            // FIXME: убрать все данные в модель, тут нужно вынести только свойства модели. line 22 25 28 31
            // FIXME: убрать все данные в модель, тут нужно вынести только свойства модели. line 22 25 28 31

            ScrollView(showsIndicators: false){
            VStack {
                    RuleItem(number: "1",
                             text: "Draw a grid with three rows and three columns, creating nine squares in total.".localized)
                    
                    RuleItem(number: "2",
                             text: "Players take turns placing their marker (X or O) in an empty square.\nTo make a move, a player selects a number corresponding to the square where they want to place their marker.".localized)
                    
                    RuleItem(number: "3",
                             text: "Player X starts by choosing a square (e.g., square 5).\nPlayer O follows by choosing an empty square (e.g., square 1).\nContinue alternating turns until the game ends.".localized)
                    
                    RuleItem(number: "4",
                             text: "The first player to align three of their markers horizontally, vertically, or diagonally wins.\nExamples of Winning Combinations:\nHorizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9\nVertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9\nDiagonal: Squares 1, 5, 9 or 3, 5, 7.")
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolBarNavigationItems(title: "How to play".localized, leftAction: { navigator.pop() })
                }
                .padding(.top, 24)
            }
        }
    }
}

#Preview {
    RulesView()
}

struct RuleItem: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Image("Ellipse 2")
                Text(number)
                    .font(.custom("SF Pro Display", size: 20))
            }
            .padding(.horizontal)
            
            Text(text)
                .padding()
                .frame(maxWidth: 350, maxHeight: 500)
                .background(Color(
                    red: 0.9,
                    green: 0.91,
                    blue: 0.98))
                .cornerRadius(30)
                .font(.custom("SF Pro Display", size: 18))
        }
        .padding(.horizontal, 16)
        .foregroundColor(Color(red: 0.14, 
                               green: 0.16,
                               blue: 0.27))
    }
}
