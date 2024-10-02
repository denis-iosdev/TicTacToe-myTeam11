//
//  CustomNavigationLinkWithAction.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 01.10.24.
//

import SwiftUI

struct CustomNavigationLinkWithAction<Label: View, Destination: View>: View {
    
    @Binding var action: Bool
    let destination: Destination
    let label: Label
    
    init(
        action: Binding<Bool>,
        @ViewBuilder destination: () -> Destination,
        @ViewBuilder label: () -> Label
    ) {
        self._action = action
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(isActive: $action) {
            CustomNavigationConteinerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }
    }
}
