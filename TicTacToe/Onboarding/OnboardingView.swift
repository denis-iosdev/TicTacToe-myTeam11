//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 29.09.24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private let buttonTitle: String = "Let's play"
    private let titleText: String = "TIC-TAC-TOE"
    
    
    var body: some View {
        
        Spacer()
        
        Image(uiImage: .logo)
            .padding(.horizontal, 60)
        
        Text(titleText)
            .font(.title)
            .bold()
            .padding(.top, 30)
        
        Spacer()
        
        MainButtonView(title: buttonTitle, style: .fill) {
            
            // TODO: add action for button
        }
        .padding(.bottom, isSmallScreen() ? 20 : 0)
    }
    
    func isSmallScreen() -> Bool {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight <= 667
    }
}

#Preview {
    OnboardingView()
}
