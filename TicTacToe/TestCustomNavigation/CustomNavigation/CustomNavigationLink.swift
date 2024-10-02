//
//  CustomNavigationLink.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 30.09.24.
//

import SwiftUI

struct CustomNavigationLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(
        @ViewBuilder destination: () -> Destination,
        @ViewBuilder label: () -> Label) 
    {
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavigationConteinerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }
    }
}

#Preview {
    CustomNavView {
        CustomNavigationLink {
            Text("Hello World!")
        } label: {
            Text("Press")
        }
    }
}
