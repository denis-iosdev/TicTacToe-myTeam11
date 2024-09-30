//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 29.09.24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectViewIsOn: Bool = false
    private let buttonTitle: String = "Let's play"
    private let titleText: String = "TIC-TAC-TOE"
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(uiImage: .logo)
                .padding(.horizontal, 60)
            
            Text(titleText)
                .font(.title)
                .bold()
                .padding(.top, 30)
            
            Spacer()
            
            NavigationLink(isActive: $selectViewIsOn) {
                // TODO: enter your next view here
                Text("SelectView")
            } label: {
                MainButtonView(title: buttonTitle, style: .fill) {
                    selectViewIsOn.toggle()
                }
                .padding(.bottom, isSmallScreen() ? 20 : 0)
            }
        }
    }
    
    func isSmallScreen() -> Bool {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight <= 667
    }
}

#Preview {
    OnboardingView()
}
