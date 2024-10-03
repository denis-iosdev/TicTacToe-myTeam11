//
//  ResultView.swift
//  TicTacToe
//
//  Created by Даниил Сивожелезов on 02.10.2024.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
        
    @Binding var isResultActive: Bool
    @Binding var isGameActive: Bool
    
    let text: String
    let imageName: String
    let playAgain: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text(text)
                    .font(.system(size: 20, weight: .bold))
                Image(imageName)
                    .resizable()
                    .frame(width: 230, height: 230)
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button {
                    playAgain()
                    dismiss()
                } label: {
                    Text("Play again")
                        .resultButton(color: .playAgainButton)
                        .background(RoundedRectangle(cornerRadius: 30).fill(.appBlue))
                }
                
                Button {
                    isResultActive = false
                    isGameActive = false
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
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 21)
        .padding(.bottom, 18)
    }
}
