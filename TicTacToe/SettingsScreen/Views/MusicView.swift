//
//  MusicView.swift
//  TicTacToe
//
//  Created by Иван Семикин on 04/10/2024.
//

import SwiftUI

struct MusicView: View {
    @Binding var isMusicEnabled: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Toggle(isOn: $isMusicEnabled) {
                    Text("Music")
                        .font(.system(size: 20, weight: .semibold))
                }
                .tint(.buttonDarkBackground)
                .padding()
                .background(Color.buttonLightBackground)
                .cornerRadius(30)
            }
        }
    }
}

#Preview {
    MusicView(isMusicEnabled: .constant(true))
}
