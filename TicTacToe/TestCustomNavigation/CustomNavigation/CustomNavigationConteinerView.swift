//
//  CustomNavigationConteinerView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 30.09.24.
//

import SwiftUI

struct CustomNavigationConteinerView<Content: View>: View {
    
    let content: Content
    var rightButtonAction: VoidBlock?
    var leftButtonAction: VoidBlock?
    
    @State private var title: String = ""
    @State private var leftButtonState: CustomLeftButton = .back
    @State private var showRightButton: Bool = true
    @State private var navBarBackgroundColor: NavigationBarBackgroundColor = .main
    
    init(
        rightButtonAction: VoidBlock? = nil,
        leftButtonAction: VoidBlock? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.rightButtonAction = rightButtonAction
        self.leftButtonAction = leftButtonAction
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationView(
                title: title,
                leftButtonState: leftButtonState,
                showRightButton: showRightButton,
                backgroundColor: navBarBackgroundColor,
                rightButtonAction: rightButtonAction,
                leftButtonAction: leftButtonAction
            )
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKeys.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarBackLeftButtonStatePreferenceKeys.self, perform: { value in
            self.leftButtonState = value
        })
        .onPreferenceChange(CustomNavBarRightButtonHiddenPreferenceKeys.self, perform: { value in
            self.showRightButton = !value
        })
        .onPreferenceChange(CustomNavBarBackgroundColorPreferenceKeys.self ,perform: { value in
            self.navBarBackgroundColor = value
        })
    }
}

#Preview {
    CustomNavigationConteinerView {
        ZStack {
            Color.green
            Text("Hello World!")
                .font(.largeTitle)
        }
    }
}
