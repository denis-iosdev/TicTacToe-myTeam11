//
//  CustomNavView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 30.09.24.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    var rightButtonAction: VoidBlock?
    var leftButtonAction: VoidBlock?
    
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
        NavigationView {
            CustomNavigationConteinerView(
                rightButtonAction: rightButtonAction,
                leftButtonAction: leftButtonAction
            ) {
                content
            }

            
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    CustomNavView {
        ZStack {
            Color.blue.ignoresSafeArea()
            Text("Hello World!")
                .foregroundStyle(.white)
                .font(.title)
        }
    }
}

// adds a swipe back feature

//extension UINavigationController {
//    
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = nil
//    }
//}
