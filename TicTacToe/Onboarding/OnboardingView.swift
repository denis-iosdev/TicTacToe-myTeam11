//
//  OnboardingView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 29.09.24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var settingViewIsOn: Bool = false
    @State private var helpViewIsOn: Bool = false
    private let buttonTitle: String = "Let's play"
    private let titleText: String = "TIC-TAC-TOE"
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $helpViewIsOn) {
                // TODO: enter your next view here
                RulesView()
            } label: { }
            
            NavigationLink(isActive: $settingViewIsOn) {
                // TODO: enter your next view here
                Text("Setting view")
            } label: { }
            
            Spacer()
            
            Image(uiImage: .logo)
                .padding(.horizontal, 60)
            
            Text(titleText)
                .font(.title)
                .bold()
                .padding(.top, 30)
            
            Spacer()
            
            NavigationLink {
                GameModesView()
            } label: {
                MainButtonView(title: buttonTitle, style: .fill)
                    .padding(.bottom, isSmallScreen() ? 20 : 0)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolBarNavigationItems(
                leftButtonState: .help,
                rightButtonHiddeb: false,
                leftAction: {
                    helpViewIsOn.toggle()
                },
                rightAction: {
                    settingViewIsOn.toggle()
                }
            )
        }
    }
    
    func isSmallScreen() -> Bool {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight <= 667
    }
}

#Preview {
    NavigationView {
        OnboardingView()
    }
}
