//
//  MainButtonView.swift
//  TicTacToe
//
//  Created by Pavel Gritskov on 29.09.24.
//

import SwiftUI

struct MainButtonView: View {
    
    enum MainButtonStyle {
        case fill, border
    }
    
    let title: String
    let style: MainButtonStyle
    
    var body: some View {
        
        Text(title)
            .font(.system(size: 20))
            .bold()
            .frame(maxWidth: .infinity)
            .frame(height: 72)
            .background(style == .fill ? .basicBlue : .white)
            .foregroundColor(style == .fill ? .white : .basicBlue)
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(style == .fill ? .white : .basicBlue, lineWidth: 2)
            }
            .padding(.horizontal, 20)
    }
}

#Preview {
    VStack {
        MainButtonView(title: "Button", style: .fill)
        
        MainButtonView(title: "Button with border", style: .border)
    }
}
