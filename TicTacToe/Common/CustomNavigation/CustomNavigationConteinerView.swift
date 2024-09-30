//
//  CustomNavigationConteinerView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 30.09.24.
//

import SwiftUI

struct CustomNavigationConteinerView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationView()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
