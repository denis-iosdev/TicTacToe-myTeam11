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
        
        CustomNavView(
            rightButtonAction: showSettingViewAction,
            leftButtonAction: showshowHelpViewAction
        ) {
            VStack {
                CustomNavigationLinkWithAction(action: $helpViewIsOn) {
                    // TODO: enter your next view here
                    Text("Help view")
                } label: { }
                
                CustomNavigationLinkWithAction(action: $settingViewIsOn) {
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
                
                CustomNavigationLink {
                    // TODO: enter your next view here
                    Text("SelectView")
                } label: {
                    MainButtonView(title: buttonTitle, style: .fill)
                        .padding(.bottom, isSmallScreen() ? 20 : 0)
                }
            }
            .customNavBarItems(leftButtonState: .help, rightButtonHidden: false)
        }
    }
    
    private func showSettingViewAction() {
        settingViewIsOn.toggle()
    }
    
    private func showshowHelpViewAction() {
        helpViewIsOn.toggle()
    }
    
    func isSmallScreen() -> Bool {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight <= 667
    }
}

#Preview {
    OnboardingView()
}
